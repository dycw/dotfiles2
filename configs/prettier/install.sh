#!/usr/bin/env sh

set -eu

###############################################################################

if command -v prettier >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'prettier' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'prettier'..."
	brew install prettier
	;;
*) ;;
esac
