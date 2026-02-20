#!/usr/bin/env sh

set -eu

###############################################################################

if command -v nvim >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'neovim' is already installed"
	exit
fi

case "$1" in
debian | macmini | macbook)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'neovim'..."
	uvx --from dycw-installer[cli]@latest set-up-neovim
	;;
*) ;;
esac
