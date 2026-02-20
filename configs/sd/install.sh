#!/usr/bin/env sh

set -eu

###############################################################################

if command -v sd >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'sd' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'sd'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y sd
	else
		sudo apt install -y sd
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'sd'..."
	brew install sd
	;;
*) ;;
esac
