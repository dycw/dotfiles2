#!/usr/bin/env sh

set -eu

###############################################################################

if command -v uv >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'uv' is already installed"
	exit
fi

case "$1" in
debian)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'uv'..."
	if [ "$(id -u)" -eq 0 ]; then
		uv -LsSf https://astral.sh/uv/install.sh |
			UV_INSTALL_DIR=/usr/local/bin UV_NO_MODIFY_PATH=1 sh
	else
		curl -LsSf https://astral.sh/uv/install.sh |
			sudo UV_INSTALL_DIR=/usr/local/bin UV_NO_MODIFY_PATH=1 sh
	fi
	;;
macmini | macbook)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'uv'..."
	brew install uv
	;;
esac
