#!/usr/bin/env sh

set -eu

###############################################################################

if command -v mdfind >/dev/null 2>&1 &&
	mdfind "kMDItemCFBundleIdentifier == 'com.mitchellh.ghostty'" >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'ghostty' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'ghostty'..."
	brew install ghostty --cask
	;;
*) ;;
esac
