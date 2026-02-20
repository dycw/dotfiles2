#!/usr/bin/env sh

set -eu

###############################################################################

if command -v mdfind >/dev/null 2>&1 &&
	mdfind "kMDItemCFBundleIdentifier == 'com.spotify.client'" >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'spotify' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'spotify'..."
	brew install spotify --cask
	;;
*) ;;
esac
