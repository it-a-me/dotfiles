#!/bin/bash
brightness="$(ddcutil --display 1 getvcp 10)"
current="$(echo $brightness | sed 's/.*current value = *\(.*\),.*/\1/')"
max="$(echo $brightness | sed 's/.*max value = *\(.*\)/\1/')"
echo $(expr $max / $current)
