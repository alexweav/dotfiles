#!/bin/bash

killall -q polybar
polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "Polybar launched..."

