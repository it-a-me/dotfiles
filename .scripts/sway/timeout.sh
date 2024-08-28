#!/bin/sh
set -eu
. "$HOME/.scripts/shutil.sh"
deps notify-send swayidle swaylock

SCREEN_TIMEOUT=500
SCREEN_LOCK=$((SCREEN_TIMEOUT - 20))
SCREEN_LOCK_WARNING=$((SCREEN_LOCK - 20))

exec swayidle -w \
    timeout $SCREEN_TIMEOUT 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    timeout $SCREEN_LOCK_WARNING 'notify-send "screen lock in 20s"' \
    timeout $SCREEN_LOCK loginctl lock-session "$XDG_SESSION_ID"
