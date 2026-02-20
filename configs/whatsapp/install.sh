#!/usr/bin/env sh

set -eu

###############################################################################

if command -v mdfind >/dev/null 2>&1 &&
	mdfind "kMDItemCFBundleIdentifier == 'net.whatsapp.WhatsApp'" >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'whatsapp' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'whatsapp'..."
	brew install whatsapp --cask
	;;
*) ;;
esac
