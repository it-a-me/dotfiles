#!/bin/bash
source $(dirname $0)/../settings.sh
pulsemixer --change-volume "${VOLUME_STEP}"
