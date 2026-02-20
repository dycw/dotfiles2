#!/usr/bin/env sh

set -eu

###############################################################################

if command -v delta >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'delta' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'delta'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y git-delta
	else
		sudo apt install -y git-delta
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'delta'..."
	brew install git-delta
	;;
*) ;;
esac
