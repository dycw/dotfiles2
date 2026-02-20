#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'shell'..."

link "${SCRIPT_DIR}/shell.sh" /etc/fish/conf.d/shell.fish
link "${SCRIPT_DIR}/shell.sh" /etc/profile.d/shell.sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'shell'"
