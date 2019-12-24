#!/usr/bin/env sh

#                    __ _ _
#   _ __  _ __ ___  / _(_) | ___
#  | '_ \| '__/ _ \| |_| | |/ _ \
# _| |_) | | | (_) |  _| | |  __/
#(_) .__/|_|  \___/|_| |_|_|\___|
#  |_|

#[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH=$PATH:$HOME/.local/bin
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="kitty"
export BROWSER="qutebrowser"

# ~/ Clean-up:
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
export INPUTRC="$HOME/.config/inputrc"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export MAILCAPS="$HOME/.local/share/mutt-wizard/"

sudo systemctl stop bluetooth.service
export GTK_USE_PORTAL=1
export QT_QPA_PLATFORMTHEME=kde
if [ "$(tty)" = "/dev/tty1" ]; then
	while true; do
		echo -e "start i3? [y/n]: "
		read yn
		case $yn in
			[Yy]*) exec startx ;;
			[Nn]*) echo "Opting out of i3"; break ;;
		esac
	done
fi
