#!/usr/bin/env sh


lockfunc() {
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

normallock() {
	touch /tmp/lockscreen.lock
	lockfunc
	rm /tmp/lockscreen.lock
}


[ "$1" == "--bypass" ] && echo "bypassing checks" && lockfunc && exit
[ -e /tmp/lockscreen.lock ] && echo "detected lock file lockscreen.lock" && exit
normallock
