#!/usr/bin/env python
import argparse
import subprocess
from types import FrameType
from typing import List
from pathlib import Path
from subprocess import Popen
from time import sleep
import signal
import shlex

processes: List[Popen] = []


def kill_processes():
    for process in processes:
        process.kill()


def sig_handler(signum: int, frame: FrameType | None):
    kill_processes()
    exit(0)


signal.signal(signal.SIGINT, sig_handler)


class WatchedFile:
    path: Path
    last_update: float = 0

    def __init__(self, path: Path) -> None:
        self.path = path

    def updated(self) -> bool:
        mtime: float = self.path.stat().st_mtime
        if mtime > self.last_update:
            self.last_update = mtime
            return True
        else:
            return False


class FileWatcher:
    commands: List[str]
    autokill: bool
    persistent: bool
    files: List[WatchedFile]
    sleep_time: float
    wipe: bool

    def __init__(self, commands: List[str], autokill: bool, files: List[Path],
                 sleep_time: float, persistent: bool, wipe: bool) -> None:
        self.commands = commands
        self.autokill = autokill
        self.persistent = persistent
        self.files = list(map(WatchedFile, files))
        self.sleep_time = sleep_time
        self.wipe = wipe

    def files_exist(self) -> bool:
        return all(map(lambda f: f.path.exists(), self.files))

    def missing_files(self) -> List[Path]:
        return list(filter(lambda p: not p.exists(),
                           map(lambda f: f.path, self.files)))

    def updated(self) -> bool:
        return all(map(WatchedFile.updated, self.files))


def parse_args() -> FileWatcher:
    parser = argparse.ArgumentParser()
    parser.add_argument("--command", "-c", action="append",
                        type=str, dest="commands", default=[], help="add a command to be executed on a file change")
    parser.add_argument("--file", "-f", action="append",
                        type=str, dest="files", default=[], help="add a file or directory to the watchlist")
    parser.add_argument("--autokill", "-k",
                        action="store_true", dest="autokill", help="kill any process still running after a file change")
    parser.add_argument("--persistent", "-p",
                        action="store_true", dest="persistent", help="restart the processes even if they exit with an non-zero exit code")
    parser.add_argument("--sleep_time", "-t",
                        action="store", dest="time", default=0.3, help="seconds to wait between file checks DEFAULT=0.3")
    parser.add_argument("--no-wipe", "-w",
                        action="store_false", dest="wipe", default=True, help="don't wipe the screen before running the program")
    args = parser.parse_args()

    if len(args.files) == 0:
        exit("please supply one or more files")
    if len(args.commands) == 0:
        exit("please supply one or more commands")
    return FileWatcher(args.commands, args.autokill, list(map(Path, args.files)), args.time, args.persistent, args.wipe)


def process_crashed(exitcode: int):
    kill_processes()
    exit(f"subprocess exited with exit code {exitcode}")


def process_still_running():
    kill_processes()
    exit(f"subprocess has not exited")


def start_processes(commands: List[str], wipe: bool):
    if wipe:
        print('\x1b[1J\x1b[0;0H', end=None, flush=True)
    for command in commands:
        print(f"running `{command}`")
        process: Popen = Popen(shlex.split(command), shell=False)
        processes.append(process)
        process.poll()
        if process.returncode is not None and process.returncode != 0:
            process_crashed(process.returncode)
    return processes


if __name__ == "__main__":
    args: FileWatcher = parse_args()
    if not args.files_exist():
        exit(f"{args.missing_files()} do not exist")
    args.updated()
    processes: List[Popen] = start_processes(args.commands, args.wipe)

    while True:
        sleep(args.sleep_time)
        if not args.files_exist():
            kill_processes()
            exit(f"{args.missing_files()} do not exist")

        for process in processes:
            process.poll()
            if process.returncode is not None and process.returncode > 0:
                if not args.persistent:
                    process_crashed(process.returncode)

        if args.updated():
            for process in processes:
                if process.returncode is None:
                    if args.autokill:
                        process.kill()
                    sleep(0.02)
                process.poll()

            if any(map(lambda p: p is None, processes)):
                process_still_running()
            processes = start_processes(args.commands, args.wipe)
