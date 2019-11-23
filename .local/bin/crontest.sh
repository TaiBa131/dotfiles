#!/bin/sh
if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi
DISPLAY=:0
notify-send "yeeeeees"
