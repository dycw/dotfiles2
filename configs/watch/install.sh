#!/usr/bin/env sh

set -eu

###############################################################################

if command -v watch >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'watch' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'watch'..."
	brew install watch
	;;
*) ;;
esac
