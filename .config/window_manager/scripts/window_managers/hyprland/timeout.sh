#!/bin/bash
source $(dirname $0)/../settings.sh
echo $WINDOW_MAN_SCRIPTS
swayidle -w \
    timeout $SCREEN_TIMEOUT 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
#    timeout $SCREEN_LOCK "$WINDOW_MAN_SCRIPTS/scripts/window_managers/wayland/swaylock.sh"
