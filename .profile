#!/usr/bin/env sh
[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH=$PATH:$HOME/.local/bin
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export EDITOR="nvim"
export R_ENVIRON="~/.Renviron"
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

sudo loadkeys /etc/nixos/keymap/personal.map
sudo systemctl stop bluetooth.service
export GTK_THEME=Adwaita:dark
#export QT_QPA_PLATFORM=wayland-egl
if [ "$(tty)" = "/dev/tty1" ]; then
	while true; do
		echo -e "start sway? [y/n]: "
		read yn
		case $yn in
			[Yy]*) exec sway ;;
			[Nn]*) echo "Opting out of sway"; break ;;
		esac
	done
fi
