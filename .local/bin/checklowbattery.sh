#!/usr/bin/env sh
status=$(acpi -b | awk '{print $3}' | sed 's/,//')
[ $status = 'Discharging' ] && capacity=$(acpi -b | awk '{print $4}' | sed 's/\%//;s/,//') && [ $capacity -lt 10 ] && systemctl suspend || echo "didnt suspend"
