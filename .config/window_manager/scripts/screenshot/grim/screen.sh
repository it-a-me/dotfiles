#/bin/bash
source $(dirname $0)/../settings.sh
SCREENSHOT_PATH=$SCREENSHOT_FORMAT
grim "$SCREENSHOT_PATH"
echo $SCREENSHOT_PATH
notify-send $SCREENSHOT_PATH
