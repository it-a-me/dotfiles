#!/bin/sh
. "$HOME"/.scripts/shutil.sh
deps slint-fmt awk

slint-fmt /dev/stdin | awk NF
