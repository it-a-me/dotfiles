#!/bin/sh
die() {
	ferr="Error: $1 in $(realpath "$0"), exiting"
	printf "$ferr\n"
	test $(command -v notify-send) && notify-send "$ferr"
	exit 1
}
test $(command -v swaymsg) || die "missing command swaymsg"
test $(command -v notify-send) || die "missing command notify-send"
test $(command -v jq) || die "missing command jq"
WORKSPACE_NAME="$1"
test ! -z "$WORKSPACE_NAME" || die "missing argument workspace-name"
VISIBLE="$(swaymsg --type get_workspaces --raw swaymsg -t get_workspaces | jq '.[] | select(.name == "'"$WORKSPACE_NAME"'").visible')"
#echo $VISIBLE
test ! "$VISIBLE" = "true" && swaymsg '[workspace=^'"$WORKSPACE_NAME"'$] move workspace to output current'
swaymsg "workspace number $WORKSPACE_NAME"
