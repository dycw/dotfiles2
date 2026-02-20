#!/usr/bin/env sh

set -eu

###############################################################################

if command -v rlwrap >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'rlwrap' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'rlwrap'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y rlwrap
	else
		sudo apt install -y rlwrap
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'rlwrap'..."
	brew install rlwrap
	;;
*) ;;
esac
