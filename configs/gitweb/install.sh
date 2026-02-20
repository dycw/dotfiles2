#!/usr/bin/env sh

set -eu

###############################################################################

if command -v gitweb >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'gitweb' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'gitweb'..."
	brew install yoannfleurydev/gitweb/gitweb
	;;
*) ;;
esac
