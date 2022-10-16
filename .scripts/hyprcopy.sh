#!/bin/sh
color="$(hyprpicker -n)"
wl-copy "${color}"
notify-send "${color}"
