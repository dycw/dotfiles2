#!/usr/bin/env sh

set -eu

###############################################################################

if command -v gh >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'gh' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'gh'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y gh
	else
		sudo apt install -y gh
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'gh'..."
	brew install gh
	;;
*) ;;
esac
