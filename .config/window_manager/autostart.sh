#!/bin/sh
CONFIG_DIR="$(realpath "$(dirname "$0")")"
. /etc/os-release
if test "$ID" = "gentoo"; then
	/usr/libexec/polkit-gnome-authentication-agent-1 &
	dbus-update-activation-environment --all &
fi

"$CONFIG_DIR"/exec/wallpaper.sh &
"$CONFIG_DIR"/scripts/window_managers/sway/timeout.sh &
if test -x ~/.local/bin/waybar; then
	~/.local/bin/waybar &> ~/.cache/waybar.log &
elif command -v waybar; then
	waybar &> ~/.cache/waybar.log
fi
test $(command -v mako) && mako
