#!/usr/bin/env sh
if [ -f /tmp/lockscreen.lock ]; then
	rm /tmp/lockscreen.lock
	pkill -RTMIN+4 i3blocks
	notify-send ' Automatic screenlock is now enabled'
else
	touch /tmp/lockscreen.lock
	pkill -RTMIN+4 i3blocks
	notify-send ' Automatic screenlock is now disabled'
fi
