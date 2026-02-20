#!/usr/bin/env sh

set -eu

###############################################################################

if command -v rg >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'ripgrep' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'ripgrep'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y ripgrep
	else
		sudo apt install -y ripgrep
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'ripgrep'..."
	brew install ripgrep
	;;
*) ;;
esac
