#!/usr/bin/env sh

set -eu

###############################################################################

if command -v tmux >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'tmux' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'tmux'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y tmux
	else
		sudo apt install -y tmux
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'tmux'..."
	brew install tmux
	;;
*) ;;
esac
