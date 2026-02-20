#!/usr/bin/env sh

set -eu

###############################################################################

if command -v tailscale >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'tailscale' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'tailscale'..."
	if [ "$(id -u)" -eq 0 ]; then
		curl -fsSL https://tailscale.com/install.sh | sh
	else
		curl -fsSL https://tailscale.com/install.sh | sudo sh
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'tailscale'..."
	brew install tailscale
	;;
*) ;;
esac
