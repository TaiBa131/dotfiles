#!/usr/bin/env sh

lockcommand() {\
	touch /tmp/lockscreen.lock
	pulsemixer --mute
	i3lock-fancy -p
	xidlehook \
	  --timer normal 10 \
	    'xset dpms force off' \
	    'xset dpms force on' \
	  --timer normal 600 \
	    '[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ] && systemctl suspend' \
	    '' &
	while true; do
		sleep 1
		if ! pgrep i3lock > /dev/null; then pkill -n xidlehook && break; fi
	done
	rm /tmp/lockscreen.lock
	}

bypass() {\
	pulsemixer --mute
	i3lock-fancy -p
	xidlehook \
	  --timer normal 10 \
	    'xset dpms force off' \
	    'xset dpms force on' \
	  --timer normal 600 \
	    '[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ] && systemctl suspend' \
	    '' &
	while true; do
		sleep 1
		if ! pgrep i3lock > /dev/null; then pkill -n xidlehook && break; fi
	done
	}


[ "$1" == "--bypass" ] && echo "bypassing checks" && bypass && exit
[ -e /tmp/lockscreen.lock ] && echo "detected lock file lockscreen.lock" && exit
lockcommand
