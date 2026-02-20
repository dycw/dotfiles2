#!/usr/bin/env sh

set -eu

###############################################################################

if command -v xsel >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'xsel' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'xsel'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y xsel
	else
		sudo apt install -y xsel
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'xsel'..."
	brew install xsel
	;;
*) ;;
esac
