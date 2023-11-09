#!/bin/bash

killall -q polybar

polybar example 2>&1 | tee -a /tmp/polybar.log & disown

if type "xrandr" > /dev/null; then
    for m in $(xrandr -q | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload example -c ~/.config/polybar/config &
    done
else
    polybar --reload example -c ~/.config/polybar/config &
fi

echo "Polybar launched..."
