#!/usr/bin/env sh
if pgrep wf-recorder > /dev/null; then
	pkill --signal=INT wf-recorder
	pkill -RTMIN+2 i3blocks
	notify-send ' Killed Screencast'
else
	wf-recorder &
	pkill -RTMIN+2 i3blocks
	echo '{"action":"update","name":"~/.local/bin/blocks/screencast"}' > ~/.swayblocks.pipe
fi
