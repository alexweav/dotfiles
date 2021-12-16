#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload main 2>&1 | tee -a /tmp/polybar-$m.log & disown
    done
else
    polybar --reload main 2>&1 | tee -a /tmp/polybar.log & disown
fi

#polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."

