#/bin/bash
source $(dirname $0)/../settings.sh
SCREENSHOT_PATH=$SCREENSHOT_FORMAT
wayshot --file $SCREENSHOT_PATH
echo "$(cat $SCREENSHOT_PATH)" | wl-copy
echo $SCREENSHOT_PATH
notify-send $SCREENSHOT_PATH
