#!/usr/bin/env sh
oldfile="$(cat $HOME/.calcurse/todo | grep 'songs to download' | sed 's/.*>//' | awk '{print $1}')"
sed -i '/songs to download/ s/.*/[0]>songstodownload.txt songs to download/' $HOME/.calcurse/todo
mv "$HOME/.calcurse/notes/$oldfile" "$HOME/.calcurse/notes/songstodownload.txt"
