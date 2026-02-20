#!/usr/bin/env sh

set -eu

###############################################################################

if command -v direnv >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'direnv' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'direnv'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y direnv
	else
		sudo apt install -y direnv
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'direnv'..."
	brew install direnv
	;;
*) ;;
esac
