#!/usr/bin/env sh

lockcommand() {\
	touch /tmp/lockscreen.lock
	pulsemixer --mute
	swaylock -i ${HOME}/.config/sway/suspendscreen.jpg -e -f -F
	swayidle timeout 10 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' &
	swayidle timeout 600 'if [ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ]; then systemctl suspend; fi' &
	while true; do
		sleep 1
		if [ $(pgrep swaylock | wc -l ) = "0" ]; then pkill -n swayidle; pkill -n swayidle; break; fi
	done
	rm /tmp/lockscreen.lock
	}

bypass() {\
	pulsemixer --mute
	swaylock -i ${HOME}/.config/sway/suspendscreen.jpg -e -f -F
	swayidle timeout 10 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' &
	swayidle timeout 600 'if [ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ]; then systemctl suspend; fi' &
	while true; do
		sleep 1
		if [ $(pgrep swaylock | wc -l ) = "0" ]; then pkill -n swayidle; pkill -n swayidle; break; fi
	done
	}


[ "$1" == "--bypass" ] && echo "bypassing checks" && bypass && exit
[ -e /tmp/lockscreen.lock ] && echo "detected lock file lockscreen.lock" && exit
lockcommand
