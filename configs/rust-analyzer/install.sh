#!/usr/bin/env sh

set -eu

###############################################################################

if command -v rust-analyzer >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'rust-analyzer' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'rust-analyzer'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y rust-analyzer
	else
		sudo apt install -y rust-analyzer
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'rust-analyzer'..."
	brew install rust-analyzer
	;;
*) ;;
esac
