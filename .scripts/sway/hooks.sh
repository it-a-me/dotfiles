#!/bin/sh
set -eu
. "$HOME"/.scripts/shutil.sh
deps swaylock swayidle loginctl

exec swayidle -w \
    before-sleep "loginctl lock-session $XDG_SESSION_ID" \
    lock ~/.scripts/sway/lock.sh
