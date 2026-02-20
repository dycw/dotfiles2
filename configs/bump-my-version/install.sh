#!/usr/bin/env sh

set -eu

###############################################################################

if command -v bump-my-version >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'bump-my-version' is already installed"
	exit
fi

case "$1" in
debian | macbook)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'bump-my-version'..."
	uv tool install bump-my-version
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'bump-my-version'..."
	brew install bump-my-version
	;;
*) ;;
esac
