#!/bin/sh
set -eu
. "$HOME"/.scripts/shutil.sh
deps swaylock
swaylock --disable-caps-lock-text --image ~/Pictures/Wallpapers/forest_lake.png
