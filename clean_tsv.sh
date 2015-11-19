#!/bin/bash
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
iconv -f "utf-8" -t "utf-8" -c $input | tr -d '\0' | tr -d '\r' | cat
