#!/usr/bin/env sh

set -eu

###############################################################################

if command -v rsync >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'rsync' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'rsync'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y rsync
	else
		sudo apt install -y rsync
	fi
	;;
*) ;;
esac
