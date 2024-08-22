#!/bin/sh
set -eu
. "$HOME"/.scripts/shutil.sh
deps jq swaymsg

ALL_POWERED_ON="$(swaymsg --raw --type get_outputs | jq '[ .[].power ] | all')"
if test "$ALL_POWERED_ON" = "true"; then
	swaymsg 'output * power off'
else
	swaymsg 'output * power on'
fi
