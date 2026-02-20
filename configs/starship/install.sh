#!/usr/bin/env sh

set -eu

###############################################################################

if command -v starship >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'starship' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'starship'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y starship
	else
		sudo apt install -y starship
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'starship'..."
	brew install starship
	;;
*) ;;
esac
