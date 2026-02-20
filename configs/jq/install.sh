#!/usr/bin/env sh

set -eu

###############################################################################

if command -v jq >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'jq' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'jq'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y jq
	else
		sudo apt install -y jq
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'jq'..."
	brew install jq
	;;
*) ;;
esac
