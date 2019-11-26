#!/usr/bin/env sh

misk() {\
	[ "$BLOCK_BUTTON" != "1" ] && [ ! -z "$BLOCK_BUTTON" ] || {
		html=$(curl -s http://www.misk.art/live)
		title="$(echo "$html" | grep 'span class="pl-item-title"' | head -n 1 | sed 's/^.*">//;s/<.*$//' | tr '[:upper:]' '[:lower:]')"
		artist="$(echo "$html" | grep 'span class="pl-item-artist"' | head -n 1 | sed 's/^.*">//;s/<.*$//' | tr '[:upper:]' '[:lower:]')"
		printf "%s - %s\n" "$artist" "$title"
		printf "%s - %s\n" "$artist" "$title" > /tmp/misktitlename
	}
	case $BLOCK_BUTTON in
		2) cat /tmp/misktitlename; echo "$(cat /tmp/misktitlename)" >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/misktitlename)"; sleep 0.5;;
		3) pkill -f "mpv http://www.misk.art/live"; rm /tmp/misktitlename;;
		4) cat /tmp/misktitlename; echo "$(cat /tmp/misktitlename)" >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/misktitlename)"; sleep 0.5;;
		5) cat /tmp/misktitlename; echo "$(cat /tmp/misktitlename)" >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/misktitlename)"; sleep 0.5;;
	esac
	exit
	}

listenmoe() {\
	[ "$BLOCK_BUTTON" != "1" ] && [ ! -z "$BLOCK_BUTTON" ] || {
	getmetadata() {
    		read -r line
    		read -r line
		title=$(echo "$line" | jq '.d.song.title' | tr -d '\"')
		artist=$(echo "$line" | jq '.d.song.artists[0].name' | tr -d '\"')
		artistRomaji=$(echo "$line" | jq '.d.song.artists[0].nameRomaji' | tr -d '\"')

		if [ "$(echo "$line" | jq '.d.song.sources[0].nameRomaji' | tr -d '\"')"
		then
			source=$(echo "$line" | jq '.d.song.sources[0].nameRomaji' | tr -d '\"')
		elif [ "$(echo "$line" | jq '.d.song.sources[0].name' | tr -d '\"')" != "null" ]
		then
			source=$(echo "$line" | jq '.d.song.sources[0].name' | tr -d '\"')
		fi

		if [ "$artistRomaji" = "null" ]
		then
			final="$artist - $title"
		else
			final="$artistRomaji - $title"
		fi
		[ ! -z "$source" ] && final="$final [$source]"
		echo "$final" >/tmp/listenmoeinfo
	}
	export -f getmetadata
	websocat wss://listen.moe/gateway_v2 sh-c:'exec sh -c getmetadata' --text
	cat /tmp/listenmoeinfo
	}
	case $BLOCK_BUTTON in
		2) cat /tmp/listenmoeinfo; cat /tmp/listenmoeinfo >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/listenmoeinfo)"; sleep 0.5;;
		3) pkill -f "mpv https://listen.moe/stream"; rm /tmp/listenmoeinfo; pkill -f "websocat wss://listen.moe/gateway_v2";;
		4) cat /tmp/listenmoeinfo; cat /tmp/listenmoeinfo >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/listenmoeinfo)"; sleep 0.5;;
		5) cat /tmp/listenmoeinfo; cat /tmp/listenmoeinfo >> ~/.calcurse/notes/songstodownload.txt && notify-send "🎶 Added to songstodownload.txt" "$(cat /tmp/listenmoeinfo)"; sleep 0.5;;
	esac
	exit
	}

examination() {\
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing examination"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --loop-file=inf /home/iheb/other/sound/examinationtime.mp3";;
	esac
	exit
	}

thundernoise() {\
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing thunder noise"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --loop-file=inf /home/iheb/other/sound/thundernoise.mp3";;
	esac
	exit
	}

brownnoise() {\
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing brownian noise"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --loop-file=inf /home/iheb/other/sound/brownnoise.mp3";;
	esac
	exit
	}

lofimix() {\
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing lofi hiphop mix"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --save-position-on-quit --loop-file=inf /home/iheb/other/sound/lofihiphopmix.mp3";;
	esac
	exit
	}

lofiradio() {\
	[ "$BLOCK_BUTTON" = "3" ] || echo "Playing lofi hiphop radio"
	case $BLOCK_BUTTON in
		3) pkill -f "mpv --no-vid https://www.youtube.com/watch\?v=hHW1oY26kxQ --ytdl-format=93";;
	esac
	exit
	}

pgrep -f "mpv http://www.misk.art/live" > /dev/null 2>&1 && misk
pgrep -f "mpv https://listen.moe/stream" > /dev/null 2>&1 && listenmoe
pgrep -f "mpv --no-vid https://www.youtube.com/watch\?v=hHW1oY26kxQ --ytdl-format=93" > /dev/null 2>&1 && lofiradio
pgrep -f "mpv --save-position-on-quit --loop-file=inf /home/iheb/other/sound/lofihiphopmix.mp3" > /dev/null 2>&1 && lofimix
pgrep -f "mpv --loop-file=inf /home/iheb/other/sound/brownnoise.mp3" > /dev/null 2>&1 && brownnoise
pgrep -f "mpv --loop-file=inf /home/iheb/other/sound/thundernoise.mp3" > /dev/null 2>&1 && thundernoise
pgrep -f "mpv --loop-file=inf /home/iheb/other/sound/examinationtime.mp3" > /dev/null 2>&1 && examination
