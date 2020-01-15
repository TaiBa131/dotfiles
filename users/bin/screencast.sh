#!/usr/bin/env sh
if pgrep -f "ffmpeg -f x11grab" > /dev/null; then
	pkill -f "ffmpeg -f x11grab"
	notify-send ' Killed Screencast'
	sleep 0.5
	pkill -RTMIN+2 i3blocks
else
	ffmpeg -f x11grab -y -r 30 -s 1366x768 -i :0.0 -preset ultrafast recording.mkv &
	sleep 0.5
	pkill -RTMIN+2 i3blocks
fi
