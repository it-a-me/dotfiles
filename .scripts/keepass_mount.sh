#!/bin/sh
. $HOME/.scripts/shutil.sh
dep rclone

rclone mount --daemon keepass: ~/Documents/keepass/sync
