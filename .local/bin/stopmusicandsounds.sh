#!/usr/bin/env sh
mpc stop
if $HOME/.local/bin/blocks/sounds.sh > /dev/null
then
	export BLOCK_BUTTON=3
	$HOME/.local/bin/blocks/sounds.sh > /dev/null
	sleep 1
	pkill -RTMIN+3 i3blocks
fi
