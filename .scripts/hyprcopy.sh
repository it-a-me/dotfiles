#!/bin/sh
. $HOME/.scripts/shutil.sh
deps wl-copy notify-send hyprpicker

color="$(hyprpicker -n)"
wl-copy "${color}"
notify-send "${color}"
