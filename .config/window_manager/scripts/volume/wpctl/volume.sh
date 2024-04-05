#!/bin/sh
exec wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -f2 -d' ' | tr -d '.' | sed -E 's/^0+(.)/\1/'
