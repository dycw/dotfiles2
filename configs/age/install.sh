#!/usr/bin/env sh

set -eu

###############################################################################

if command -v age >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'age' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'age'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y age
	else
		sudo apt install -y age
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'age'..."
	brew install age
	;;
*) ;;
esac
