#!/usr/bin/env sh

set -eu

###############################################################################

if command -v luarocks >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'luarocks' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'luarocks'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y luarocks
	else
		sudo apt install -y luarocks
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'luarocks'..."
	brew install luarocks
	;;
*) ;;
esac
