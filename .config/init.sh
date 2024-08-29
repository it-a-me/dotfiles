#!/bin/sh

update_environment() {
	set -a
	eval "$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)"
	set +a
}

update_environment
test "$(command -v fish)" && exec fish
