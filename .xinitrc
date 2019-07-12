#!/bin/sh
#
# ~/.xinitrc
#
# Executed by `startx`.

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Use ~/.Xresources for overrides
xrdb ~/.Xresources

# Set background
~/.fehbg &

exec xmonad

