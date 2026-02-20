#!/usr/bin/env sh

set -eu

###############################################################################

if command -v fish >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'fish' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'fish'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y fish
	else
		sudo apt install -y fish
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'fish'..."
	brew install fish
	;;
*) ;;
esac
