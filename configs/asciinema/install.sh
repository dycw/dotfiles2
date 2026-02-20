#!/usr/bin/env sh

set -eu

###############################################################################

if command -v asciinema >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'asciinema' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'asciinema'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y asciinema
	else
		sudo apt install -y asciinema
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'asciinema'..."
	brew install asciinema
	;;
*) ;;
esac
