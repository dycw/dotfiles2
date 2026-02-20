#!/usr/bin/env sh

set -eu

###############################################################################

if command -v pgcli >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'pgcli' is already installed"
	exit
fi

case "$1" in
debian | macmini | macbook)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'pgcli'..."
	uv tool install pgcli
	;;
*) ;;
esac
