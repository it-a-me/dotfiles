#!/bin/sh

update_environment() {
	set -a
	TMP="$(mktemp)"
	/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator > "${TMP}"
	. "${TMP}"
	set +a
}

update_environment
test "$(command -v fish)" && exec fish
