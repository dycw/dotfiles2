#!/usr/bin/env sh

set -eu

###############################################################################

if command -v just >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'just' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'just'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y just
	else
		sudo apt install -y just
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'just'..."
	brew install just
	;;
*) ;;
esac
