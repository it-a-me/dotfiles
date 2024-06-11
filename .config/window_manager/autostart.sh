#!/bin/sh
CONFIG_DIR="$(realpath "$(dirname $0)")"
. /etc/os-release
if test "$ID" = "gentoo"; then
	/usr/libexec/polkit-gnome-authentication-agent-1 &
	dbus-update-activation-environment --all &
fi

$CONFIG_DIR/exec/wallpaper.sh &
$CONFIG_DIR/scripts/window_managers/sway/timeout.sh &
~/.local/bin/waybar > ~/.cache/waybar.log &
test $(command -v mako) && mako
