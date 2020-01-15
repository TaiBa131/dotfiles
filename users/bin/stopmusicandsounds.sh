#!/usr/bin/env sh
export BLOCK_BUTTON=3
$HOME/.local/bin/blocks/sounds.sh > /dev/null
mpc stop
sleep 0.5
pkill -RTMIN+3 i3blocks
