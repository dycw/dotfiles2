#!/usr/bin/env sh

set -eu

###############################################################################

if command -v brew >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'brew' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'brew'..."
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	;;
*) ;;
esac
