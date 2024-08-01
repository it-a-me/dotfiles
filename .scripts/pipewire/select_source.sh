#!/bin/sh
. "${HOME}/.scripts/shutil.sh"
deps fuzzel wpctl

SOURCES="$(~/.scripts/pipewire/get_sources.sh)"
SOURCE="$(printf "%s" "$SOURCES" | jq -r '.[] | if .default == true then "* " + .description else .description end' | fuzzel --dmenu)"
test $? = 0 || exit 1
printf "%s" "$SOURCE" | grep -E '^\* ' && exit 2

ID="$(printf "%s" "$SOURCES" | jq -r --arg source "$SOURCE" '.[] | select(.description == $source) | .id')"
wpctl set-default "$ID"



