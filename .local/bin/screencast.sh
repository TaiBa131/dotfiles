#!/usr/bin/env sh
if pgrep wf-recorder > /dev/null; then
	pkill --signal=INT wf-recorder
	notify-send ' Killed Screencast'
	pkill -RTMIN+2 i3blocks
	pkill -RTMIN+2 i3blocks
else
	wf-recorder &
	pkill -RTMIN+2 i3blocks
	pkill -RTMIN+2 i3blocks
fi
