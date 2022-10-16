#!/bin/bash
echo $HOME
tar \
--exclude "${HOME}/tmp"    \
--exclude "${HOME}/.local/share/containers"    \
--exclude "${HOME}/.cache" \
--exclude "${HOME}/.cargo" \
--exclude "${HOME}/.rustup" \
--exclude "${HOME}/.local/share/flatpak" \
--exclude "${HOME}/Documents/android" \
--exclude "${HOME}/Crypt" \
--exclude "${HOME}/Documents/void-packages/masterdir" \
-cvf ~/tmp/backup.tar $HOME
