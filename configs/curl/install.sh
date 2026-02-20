#!/usr/bin/env sh

set -eu

###############################################################################

if command -v curl >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'curl' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'curl'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y curl
	else
		sudo apt install -y curl
	fi
	;;
*) ;;
esac
