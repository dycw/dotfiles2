#!/usr/bin/env sh

set -eu

###############################################################################

if command -v fzf >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'fzf' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'fzf'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y fzf
	else
		sudo apt install -y fzf
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'fzf'..."
	brew install fzf
	;;
*) ;;
esac
