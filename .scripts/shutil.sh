#!/bin/sh
export SCRIPT_NAME="$(realpath $0)"

function throw {
	ERR="$(printf "error running ${SCRIPT_NAME}:\n$1")"
	if command -v notify-send >/dev/null; then
		notify-send "$ERR"
	fi
	printf "$ERR" >&2
	exit 1
}


function dep {
	if ! command -v $1 >/dev/null; then
		throw "command '$1' not found"
	fi
}

function deps {
	for dependency in $@; do
		dep $dependency
	done
}
