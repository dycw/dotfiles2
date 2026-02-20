#!/usr/bin/env sh

set -eu

###############################################################################

if command -v ruff >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'ruff' is already installed"
	exit
fi

case "$1" in
debian | macmini | macbook)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'ruff'..."
	uv tool install ruff
	;;
*) ;;
esac
