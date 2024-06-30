#!/bin/sh
grep -E '\)( (const|override))*;' "$1" | sed -E 's/^\s+//g;s/;/ {\n}/g;s/(\w+\()/CLASS::\1/g'
