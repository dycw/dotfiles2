#!/usr/bin/env sh

set -eu

###############################################################################

if command -v dnsmasq >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'dnsmasq' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'dnsmasq'..."
	brew install dnsmasq
	;;
*) ;;
esac
