#!/usr/bin/env sh

set -eu

###############################################################################

if command -v eza >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'eza' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'eza'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y eza
	else
		sudo apt install -y eza
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'eza'..."
	brew install eza
	;;
*) ;;
esac
