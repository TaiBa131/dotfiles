#!/usr/bin/env sh
pactl subscribe | grep --line-buffered "sink" | while read
do
	pkill -RTMIN+10 i3blocks
done
