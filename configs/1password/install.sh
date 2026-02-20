#!/usr/bin/env sh

set -eu

###############################################################################

if command -v mdfind && mdfind "kMDItemCFBundleIdentifier == 'com.1password.1password'"; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] '1Password' is already installed"
	exit
fi

case "$1" in
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing '1Password'..."
	brew install 1password
	;;
*) ;;
esac
