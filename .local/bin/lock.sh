#!/bin/sh

lockcommand() {\
	touch /tmp/lockscreen.lock
	pulsemixer --mute && pkill -RTMIN+10 i3blocks
	grim /tmp/screen.jpg
	convert /tmp/screen.jpg -scale 10% -scale 1000% /tmp/screen.jpg
	convert /tmp/screen.jpg ${HOME}/.config/sway/lockicon.png -gravity center -composite -matte /tmp/screen.jpg
	swaylock -i /tmp/screen.jpg -e -f -F
	sleep 1
	swaymsg "output * dpms off"
	swayidle timeout 1 '' resume 'swaymsg "output * dpms on"' &
	swayidle timeout 10 'swaymsg "output * dpms off"' &
	swayidle timeout 600 '[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ] && systemctl suspend' &
	while true; do
		sleep 0.05
		[ $(pgrep swaylock | wc -l ) = "0" ] && pkill -n swayidle && pkill -n swayidle && pkill -n swayidle && break
	done
	rm /tmp/screen.jpg
	sleep 5
	rm /tmp/lockscreen.lock
	}

bypass() {\
	pulsemixer --mute && pkill -RTMIN+10 i3blocks
	grim /tmp/screen.jpg
	convert /tmp/screen.jpg -scale 10% -scale 1000% /tmp/screen.jpg
	convert /tmp/screen.jpg ${HOME}/.config/sway/lockicon.png -gravity center -composite -matte /tmp/screen.jpg
	swaylock -i /tmp/screen.jpg -e -f -F
	sleep 1
	swaymsg "output * dpms off"
	swayidle timeout 1 '' resume 'swaymsg "output * dpms on"' &
	swayidle timeout 10 'swaymsg "output * dpms off"' &
	swayidle timeout 600 '[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ] && systemctl suspend' &
	while true; do
		sleep 0.05
		[ $(pgrep swaylock | wc -l ) = "0" ] && pkill -n swayidle && pkill -n swayidle && pkill -n swayidle && break
	done
	rm /tmp/screen.jpg
	}



[ "$1" == "--bypass" ] && echo "bypassing checks" && bypass && exit

[ -e /tmp/lockscreen.lock ] && echo "detected lock file lockscreen.lock" && exit
swaymsg -t get_tree | grep "\"fullscreen_mode\": 1," && exit
lockcommand
