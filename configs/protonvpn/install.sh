#!/usr/bin/env sh

set -eu

###############################################################################

if command -v mdfind >/dev/null 2>&1 &&
	mdfind "kMDItemCFBundleIdentifier == 'ch.protonvpn.mac'" >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'protonvpn' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'protonvpn'..."
	brew install protonvpn --cask
	;;
*) ;;
esac
