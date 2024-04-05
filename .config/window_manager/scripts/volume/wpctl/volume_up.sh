#!/bin/sh
. $(dirname "$0")/../settings.sh
test $($(dirname "$0")/volume.sh) -lt 150 || exit 0
exec wpctl set-volume @DEFAULT_AUDIO_SINK@ "${VOLUME_STEP}%+"
