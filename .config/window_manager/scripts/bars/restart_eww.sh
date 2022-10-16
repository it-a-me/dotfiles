#!/bin/bash
if [[ "$(eww ping)" == "pong" ]]; then
   if ! eww windows | grep "\*bar" ; then eww open bar; fi
else
   eww open bar
fi
