#!/usr/bin/env sh

set -eu

###############################################################################

if command -v redis-cli >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'postgres' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'postgres'..."
	brew install postgresql@18
	brew services start postgresql@18
	;;
*) ;;
esac
