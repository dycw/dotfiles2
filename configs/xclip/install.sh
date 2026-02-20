#!/usr/bin/env sh

set -eu

###############################################################################

if command -v xclip >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'xclip' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'xclip'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y xclip
	else
		sudo apt install -y xclip
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'xclip'..."
	brew install xclip
	;;
*) ;;
esac
