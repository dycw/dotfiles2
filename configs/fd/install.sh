#!/usr/bin/env sh

set -eu

###############################################################################

if command -v fd >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'fd' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'fd'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y fd-find
	else
		sudo apt install -y fd-find
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'fd'..."
	brew install fd
	;;
*) ;;
esac
