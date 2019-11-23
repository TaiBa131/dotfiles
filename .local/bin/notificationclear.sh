#!/usr/bin/env sh
[ -f /tmp/notificationlock ] && echo "notificationlock exists" && exit
if makoctl list | grep app-name > /dev/null
then
	if ! swaymsg -t get_tree | grep "\"fullscreen_mode\": 1," > /dev/null
	then
		touch /tmp/notificationlock
		sleep 10
		makoctl dismiss -a
		rm /tmp/notificationlock
	fi
fi
