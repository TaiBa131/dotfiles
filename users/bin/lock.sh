#!/usr/bin/env bash

lockfunc() {
	pulsemixer --mute
	i3lock-fancy -p
	sleep 1
	xset dpms force off
	xidlehook \
	  --timer normal 1 \
	    '' \
	    'xset dpms force on' \
	  --timer normal 10 \
	    'xset dpms force off' \
	    '' \
	  --timer normal 600 \
	    '[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ] && systemctl suspend' \
	    '' &
	while true; do
		sleep 1
		if ! pgrep i3lock-fancy > /dev/null; then pkill -n xidlehook && break; fi
	done
}

locknormal() {
	touch /tmp/lockscreen.lock
	lockfunc
	sleep 5
	rm /tmp/lockscreen.lock
}

[ "$1" == "--bypass" ] && echo "bypassing checks" && lockfunc && exit

[ -e /tmp/lockscreen.lock ] && echo "detected lock file lockscreen.lock" && exit
i3-msg -t get_tree | jq -e 'recurse(.nodes[]; .nodes) | select(.focused and .type=="con").fullscreen_mode == 1' > /dev/null && exit
locknormal
