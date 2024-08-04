#!/bin/sh
. "$HOME"/.scripts/shutil.sh
deps jq wpctl

SOURCES="$("$HOME"/.scripts/pipewire/get_sources.sh)"
STATE="$(printf "%s" "$SOURCES" | jq '.[] | select(.default).mute')"
IDS="$(printf "%s" "$SOURCES" | jq '.[].id')"
for id in $IDS; do
    if test "$STATE" = "true"; then
        wpctl set-mute $id 0;
    else
        wpctl set-mute $id 1;
    fi
done
