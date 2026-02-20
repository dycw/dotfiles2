#!/usr/bin/env sh

set -eu

###############################################################################

if command -v vlc >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'vlc' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'whatsapp'..."
	brew install vlc --cask
	;;
*) ;;
esac
