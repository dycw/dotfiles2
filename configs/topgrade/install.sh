#!/usr/bin/env sh

set -eu

###############################################################################

if command -v topgrade >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'topgrade' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'topgrade'..."
	brew install topgrade
	;;
*) ;;
esac
