#!/bin/sh
source $(dirname $0)/../settings.sh
exec wpctl set-volume @DEFAULT_AUDIO_SINK@ "${VOLUME_STEP}%-"
