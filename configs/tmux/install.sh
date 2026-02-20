#!/usr/bin/env sh

set -eu

###############################################################################

if command -v tmux >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'tmux' is already installed..."
else
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'tmux'..."
	case "$1" in
	debian)
		if [ "$(id -u)" -eq 0 ]; then
			apt install -y tmux
		else
			sudo apt install -y tmux
		fi
		;;
	*)
		echo "Unsupported system '$1'; exiting..." >&2
		exit 1
		;;
	esac
fi
