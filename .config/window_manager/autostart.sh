#!/usr/bin/env dash
. /etc/os-release
if test "$ID" = "gentoo"; then
	/usr/libexec/polkit-gnome-authentication-agent-1 &
fi
