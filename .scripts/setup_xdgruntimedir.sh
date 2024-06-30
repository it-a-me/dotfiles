#!/bin/bash
if test -z "${XDG_RUNTIME_DIR}"; then
   XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir
   export XDG_RUNTIME_DIR
  if ! test -d "${XDG_RUNTIME_DIR}"; then
    mkdir "${XDG_RUNTIME_DIR}"
    chmod 0700 "${XDG_RUNTIME_DIR}"
  fi
fi
