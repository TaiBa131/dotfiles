#!/usr/bin/env sh
BLOCK_BUTTON=3 personalblocks sounds
mpc stop
sleep 0.5
pkill -RTMIN+3 i3blocks
