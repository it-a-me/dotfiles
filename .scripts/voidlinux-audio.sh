#!/bin/sh
. $HOME/.scripts/shutil.sh
deps dbus-run-session wireplumber pipewire-pulse

dbus-run-session pipewire &
wireplumber & 
pipewire-pulse & 
