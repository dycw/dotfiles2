#!/usr/bin/env sh

set -eu

###############################################################################

if command -v agg >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'agg' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'agg'..."
	brew install agg
	;;
*) ;;
esac
