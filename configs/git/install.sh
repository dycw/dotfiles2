#!/usr/bin/env sh

set -eu

###############################################################################

if command -v git >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'git' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'git'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y git
	else
		sudo apt install -y git
	fi
	;;
*) ;;
esac
