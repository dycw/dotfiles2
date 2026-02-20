#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'ipython'..."

link "${SCRIPT_DIR}/shell.fish" /etc/fish/conf.d/ipython.fish

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'ipython'"
