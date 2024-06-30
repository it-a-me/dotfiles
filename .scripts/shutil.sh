#!/bin/sh
SCRIPT_NAME="$(realpath "$0")"

throw() {
	ERR="$(printf "error running %s:\n%s" "$SCRIPT_NAME" "$1")"
	if command -v notify-send >/dev/null; then
		notify-send "$ERR"
	fi
	printf "%s" "$ERR" >&2
	exit 1
}


dep() {
	if ! command -v "$1" >/dev/null; then
		throw "command '$1' not found"
	fi
}

deps() {
	for dependency in "$@"; do
		dep "$dependency"
	done
}
