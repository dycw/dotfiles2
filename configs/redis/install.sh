#!/usr/bin/env sh

set -eu

###############################################################################

if command -v redis-cli >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'redis' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'redis'..."
	brew install redis-stack --cask
	brew services start redis
	;;
*) ;;
esac
