#/bin/sh
while true; do
	swaymsg -t subscribe '[ "workspace" ]'
	if [ ! $programislaunched ]; then
		keepassxc
		programislaunched=true
	fi
done
