#!/usr/bin/env sh

set -eu

###############################################################################

if command -v luacheck >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'luacheck' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'luacheck'..."
	script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
	sh "$(cd -- "${script_dir}")"/luarocks/install.sh debian
	if [ "$(id -u)" -eq 0 ]; then
		luarocks install luacheck
	else
		sudo luarocks install luacheck
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'luacheck'..."
	brew install luacheck
	;;
*) ;;
esac
