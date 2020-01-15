#!/usr/bin/env bash
extracolor () {
	{ read x; read y; read z; } < <(sed "s/,/\n/g" ~/.cache/wal/variables)
	case $1 in
		dark) {
			let x=x+35
			let y=y+35
			let z=z+35
			echo "dark" > ~/.cache/wal/type
		};;
		light) {
			let x=x-35
			let y=y-35
			let z=z-35
			echo "light" > ~/.cache/wal/type
		};;
	esac
	x=$(printf "%x\n" "$x")
	y=$(printf "%x\n" "$y")
	z=$(printf "%x\n" "$z")
	[ $(echo $x | wc -m) -eq 2 ] && x="0$x"
	[ $(echo $y | wc -m) -eq 2 ] && x="0$y"
	[ $(echo $z | wc -m) -eq 2 ] && x="0$z"
	echo "#$x$y$z" >> ~/.cache/wal/colors
	echo "*lighter: #$x$y$z" >> ~/.cache/wal/colors.Xresources
	xrdb ~/.cache/wal/colors.Xresources
	i3-msg -q reload
}
TYPE=$(cat ~/.cache/wal/type)
wal -e -R
case $TYPE in
	dark) extracolor dark ;;
	light) extracolor light ;;
esac
