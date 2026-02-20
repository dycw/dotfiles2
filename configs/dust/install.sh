#!/usr/bin/env sh

set -eu

###############################################################################

if command -v dust >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'dust' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'dust'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y du-dust
	else
		sudo apt install -y du-dust
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'dust'..."
	brew install dust
	;;
*) ;;
esac
