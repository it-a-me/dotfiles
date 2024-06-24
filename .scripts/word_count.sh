#!/bin/sh
. $HOME/.scripts/shutil.sh
deps wl-paste notify-send wc
 
WORDS="$(wl-paste | wc -w)"
notify-send "clipboard contains $WORDS words"
