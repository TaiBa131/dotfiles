#!/usr/bin/env bash


normalradio() {
	[ ! -z "$BLOCK_BUTTON" ] || {
		FORMAT="[%artist% - ]|[%artist% - ]&%title%"
		mpc -f "$FORMAT" current > /tmp/radiotitle
		cat /tmp/radiotitle
	}
	case $BLOCK_BUTTON in
		1) cat /tmp/radiotitle; i3-msg -q -- exec $TERMINAL -e ncmpcpp & ;;
		[2,4,5]) cat /tmp/radiotitle; echo "$(cat /tmp/radiotitle)" >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/radiotitle)"; sleep 0.5;;
		3) mpc -q update; mpc -q clear; mpc add /; rm /tmp/radiotitle;;
	esac
	exit
}

pianorama() {
	[ ! -z "$BLOCK_BUTTON" ] || {
		FORMAT="%title%"
		mpc -f "$FORMAT" current > /tmp/radiotitle
		cat /tmp/radiotitle
	}
	case $BLOCK_BUTTON in
		1) cat /tmp/radiotitle; i3-msg -q -- exec $TERMINAL -e ncmpcpp & ;;
		[2,4,5]) cat /tmp/radiotitle; echo "$(cat /tmp/radiotitle)" >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/radiotitle)"; sleep 0.5;;
		3) mpc -q update; mpc -q clear; mpc add /; rm /tmp/radiotitle;;
	esac
	exit
}

misk() {
	[ "$BLOCK_BUTTON" != "1" ] && [ ! -z "$BLOCK_BUTTON" ] || {
		html=$(curl -s http://www.misk.art/live)
		title="$(echo "$html" | grep 'span class="pl-item-title"' | head -n 1 | sed 's/^.*">//;s/<.*$//' | tr '[:upper:]' '[:lower:]')"
		artist="$(echo "$html" | grep 'span class="pl-item-artist"' | head -n 1 | sed 's/^.*">//;s/<.*$//' | tr '[:upper:]' '[:lower:]')"
		printf "%s - %s\n" "$artist" "$title"
		printf "%s - %s\n" "$artist" "$title" > /tmp/misktitlename
	}
	case $BLOCK_BUTTON in
		[2,4,5]) cat /tmp/misktitlename; echo "$(cat /tmp/misktitlename)" >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/misktitlename)"; sleep 0.5;;
		3) pkill -f "mpv http://live.misk.tn:8000/stream"; rm /tmp/misktitlename;;
	esac
	exit
}

examination() {
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing examination"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --loop-file=inf /home/iheb/other/sound/examinationtime.mp3";;
	esac
	exit
}

thundernoise() {
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing thunder noise"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --loop-file=inf /home/iheb/other/sound/thundernoise.mp3";;
	esac
	exit
}

brownnoise() {
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing brownian noise"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --loop-file=inf /home/iheb/other/sound/brownnoise.mp3";;
	esac
	exit
}

lofimix() {
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing lofi hiphop mix"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --save-position-on-quit --loop-file=inf /home/iheb/other/sound/lofihiphopmix.mp3";;
	esac
	exit
}

lofiradio() {
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing lofi hiphop radio"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --no-vid https://www.youtube.com/watch\?v=hHW1oY26kxQ --ytdl-format=93";;
	esac
	exit
}

file=$(mpc current -f "%file%")
if [ "$file" = "https://listen.moe/stream" ] || [[ "$file" =~ ^https:\/\/lainon\.life\/radio\/.*\.ogg$ ]]; then normalradio; fi
[ "$file" = "http://stream.pianoramaradio.ru" ] && pianorama
pgrep -f "mpv http://live.misk.tn:8000/stream" > /dev/null 2>&1 && misk
pgrep -f "mpv --no-vid https://www.youtube.com/watch\?v=hHW1oY26kxQ --ytdl-format=93" > /dev/null 2>&1 && lofiradio
pgrep -f "mpv --save-position-on-quit --loop-file=inf /home/iheb/other/sound/lofihiphopmix.mp3" > /dev/null 2>&1 && lofimix
pgrep -f "mpv --loop-file=inf /home/iheb/other/sound/brownnoise.mp3" > /dev/null 2>&1 && brownnoise
pgrep -f "mpv --loop-file=inf /home/iheb/other/sound/thundernoise.mp3" > /dev/null 2>&1 && thundernoise
pgrep -f "mpv --loop-file=inf /home/iheb/other/sound/examinationtime.mp3" > /dev/null 2>&1 && examination
exit 1
