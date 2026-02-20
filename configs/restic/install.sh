#!/usr/bin/env sh

set -eu

###############################################################################

if command -v restic >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'restic' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'restic'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y restic
	else
		sudo apt install -y restic
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'restic'..."
	brew install restic
	;;
*) ;;
esac
