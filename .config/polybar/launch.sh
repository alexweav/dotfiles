#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)
export BATTERY=$(ls -la /sys/class/power_supply | grep 'BAT' | awk '{print $9}' | head -n1)

echo $DEFAULT_NETWORK_INTERFACE

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload main 2>&1 | tee -a /tmp/polybar-$m.log & disown
    done
else
    polybar --reload main 2>&1 | tee -a /tmp/polybar.log & disown
fi

echo "Polybar launched..."

