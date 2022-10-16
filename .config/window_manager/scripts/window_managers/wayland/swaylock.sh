#!/bin/bash
source $(dirname $0)/../settings.sh
swaylock --ignore-empty-password --daemonize --disable-caps-lock-text --image $WALLPAPER_PATH
