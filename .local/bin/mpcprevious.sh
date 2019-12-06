#!/usr/bin/env sh
time=$(mpc | sed -n 2p | awk '{print $3}' | sed 's/\/.*//')
min=$(echo $time | sed 's/\:.*//' )
sec=$(echo $time | sed 's/\.*://' )
if [ $min -eq 0 ] && [ $sec -lt 6 ]
then mpc -q prev
else mpc -q seek 0
fi

