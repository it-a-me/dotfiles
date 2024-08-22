#!/bin/bash
VOLUME_STEP=5
BRIGHTNESS_STEP=40
SCREENSHOT_FORMAT="$(date +"$(xdg-user-dir PICTURES)/screenshots/%Y-%m-%d_%H:%M:%S.png")"
SCREEN_TIMEOUT="500"
SCREEN_LOCK="360"
WALLPAPER_PATH="$HOME/Pictures/Wallpapers/forest_lake.png"
WINDOW_MAN_SCRIPTS="$(dirname "$(realpath "$BASH_SOURCE")")"
