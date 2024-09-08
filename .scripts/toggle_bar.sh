#!/bin/sh
. "$HOME"/.scripts/shutil.sh
deps waybar pgrep

if ! pkill --signal SIGTERM -x waybar; then
    nohup waybar > ~/.cache/waybar.log 2>/dev/null &
fi
