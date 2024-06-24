#!/bin/sh
. $HOME/.scripts/shutil.sh
deps swaymsg jq

if test -z "$1"; then
  printf 'please supply the name of a monitor as the first argument, ex (`%s "DP-1"`)\n' "$0"
  exit 1
fi
if test ! "$(swaymsg -rt get_outputs | jq --arg output "$1" 'map(.name == $output) | any')" = "true"; then
  printf 'invalid monitor\n'
  exit 1
fi
dpms="$(swaymsg -rt get_outputs | jq --arg output "$1" 'map(select(.name == $output))[0].dpms')"
swaymsg output "$1" dpms toggle
echo $dpms
