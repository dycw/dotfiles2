#!/usr/bin/env sh

set -eu

###############################################################################

if command -v bat >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'bat' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'bat'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y bat
	else
		sudo apt install -y bat
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'bat'..."
	brew install bat
	;;
*) ;;
esac
