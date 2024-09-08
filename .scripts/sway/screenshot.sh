#!/bin/sh
set -eu
. "$HOME"/.scripts/shutil.sh
deps jq grim
OUTPUT="$(swaymsg -t get_outputs --raw | jq -r '.[] | select(.focused).name')"
NAME="screenshot-$(date +'%F-%T').png"
SCREENSHOT_PATH="$HOME/Pictures/screenshots/$NAME"
grim -t png -o "$OUTPUT" "$SCREENSHOT_PATH"
notify-send "Screenshot saved to $SCREENSHOT_PATH"
