#!/bin/bash
#set -x
if ! mpc > /dev/null 2>&1; then
    echo "server offline"
    exit 1
elif mpc status | grep -q "playing"; then
    mpc current | zscroll -l 15 -d 1.2 &
elif mpc status | grep -q "pause"; then
    mpc current | zscroll -l 15 -d 1.2 &
else
    echo "Not playing"
fi
mpc idle > /dev/null
