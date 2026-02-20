#!/usr/bin/env sh

set -eu

###############################################################################

if command -v zoxide >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'zoxide' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'zoxide'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y zoxide
	else
		sudo apt install -y zoxide
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'zoxide'..."
	brew install zoxide
	;;
*) ;;
esac
