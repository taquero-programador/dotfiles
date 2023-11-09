#!/bin/bash
#set -x
if ! mpc > /dev/null 2>&1; then
    echo "server offline"
    exit 1
elif mpc status | grep -Eiq "^\[(playing|paused)\]"; then
    mpc current | zscroll -l 15 -d 0.5 &
else
    echo "Not playing"
fi
mpc idle > /dev/null
