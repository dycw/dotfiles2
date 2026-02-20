#!/usr/bin/env sh

set -eu

###############################################################################

if command -v yq >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'yq' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'yq'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y yq
	else
		sudo apt install -y yq
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'yq'..."
	brew install yq
	;;
*) ;;
esac
