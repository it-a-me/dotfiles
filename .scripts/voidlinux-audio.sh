#!/bin/bash
dbus-run-session pipewire &
wireplumber & 
pipewire-pulse & 
