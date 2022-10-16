#!/bin/bash
source $(dirname $0)/../settings.sh
exec swayidle -w \
    timeout $SCREEN_TIMEOUT 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    timeout $(($SCREEN_TIMEOUT-20)) 'notify-send "screen timeout in 20s"'\
    timeout $(($SCREEN_LOCK + $SCREEN_TIMEOUT)) "$WINDOW_MAN_SCRIPTS/scripts/window_managers/wayland/swaylock.sh"
