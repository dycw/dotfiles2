#!/usr/bin/env sh

set -eu

###############################################################################

if command -v mdfind >/dev/null 2>&1 &&
	mdfind "kMDItemCFBundleIdentifier == 'com.1password.1password'" >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] '1password' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing '1password'..."
	brew install 1password --cask
	;;
*) ;;
esac
