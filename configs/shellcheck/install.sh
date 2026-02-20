#!/usr/bin/env sh

set -eu

###############################################################################

if command -v shellcheck >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'shellcheck' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'shellcheck'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y shellcheck
	else
		sudo apt install -y shellcheck
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'shellcheck'..."
	brew install shellcheck
	;;
*) ;;
esac
