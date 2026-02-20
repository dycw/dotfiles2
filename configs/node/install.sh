#!/usr/bin/env sh

set -eu

###############################################################################

if command -v node >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'node' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'node'..."
	brew install node
	;;
*) ;;
esac
