#!/bin/bash
source $(dirname $0)/../settings.sh
ddcutil --display 1 setvcp 10 - $BRIGHTNESS_STEP
