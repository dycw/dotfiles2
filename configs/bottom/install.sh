#!/usr/bin/env sh

set -eu

###############################################################################

if command -v btm >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'bottom' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'bottom'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y btm
	else
		sudo apt install -y btm
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'bottom'..."
	brew install btm
	;;
*) ;;
esac
