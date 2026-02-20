#!/usr/bin/env sh

set -eu

###############################################################################

if command -v ggrep >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'ggrep' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'ggrep'..."
	brew install ggrep
	;;
*) ;;
esac
