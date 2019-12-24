#!/usr/bin/env sh
if pgrep -f "ffmpeg -f x11grab" > /dev/null; then
	pkill -f "ffmpeg -f x11grab"
	pkill -RTMIN+2 i3blocks
	notify-send ' Killed Screencast'
else
	ffmpeg -f x11grab -y -r 25 -vsync 1 -s 1366x768 -i :0.0 -preset ultrafast recording.mp4 &
	pkill -RTMIN+2 i3blocks
fi
