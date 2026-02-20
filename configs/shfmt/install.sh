#!/usr/bin/env sh

set -eu

###############################################################################

if command -v shfmt >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'shfmt' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'shfmt'..."
	if [ "$(id -u)" -eq 0 ]; then
		apt install -y shfmt
	else
		sudo apt install -y shfmt
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'shfmt'..."
	brew install shfmt
	;;
*) ;;
esac
