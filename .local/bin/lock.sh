#!/bin/sh

lockcommand() {\
	touch /tmp/lockscreen.lock
	pulsemixer --mute
	maim -u -m 5 /tmp/screen.jpg
	convert /tmp/screen.jpg -scale 10% -scale 1000% /tmp/screen.jpg
	convert /tmp/screen.jpg ${HOME}/.config/sway/lockicon.png -gravity center -composite -matte -resize 1366x768 RGB:- | i3lock --raw 1366x768:rgb --image /dev/stdin -e -f
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
		if ! pgrep i3lock > /dev/null; then pkill -n xidlehook && break; fi
	done
	rm /tmp/screen.jpg
	sleep 5
	rm /tmp/lockscreen.lock
	}

bypass() {\
	pulsemixer --mute
	maim -u /tmp/screen.jpg
	convert /tmp/screen.jpg -scale 10% -scale 1000% /tmp/screen.jpg
	convert /tmp/screen.jpg ${HOME}/.config/sway/lockicon.png -gravity center -composite -matte -resize 1366x768 RGB:- | i3lock --raw 1366x768:rgb --image /dev/stdin -e -f
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
		if ! pgrep i3lock > /dev/null; then pkill -n xidlehook && break; fi
	done
	rm /tmp/screen.jpg
	}



[ "$1" == "--bypass" ] && echo "bypassing checks" && bypass && exit

[ -e /tmp/lockscreen.lock ] && echo "detected lock file lockscreen.lock" && exit
i3-msg -t get_tree | jq -e 'recurse(.nodes[]; .nodes) | select(.focused and .type=="con").fullscreen_mode == 1' > /dev/null && exit
lockcommand
