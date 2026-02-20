#!/usr/bin/env sh

###############################################################################

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'git'..."

link "${SCRIPT_DIR}/config" /etc/gitconfig
link "${SCRIPT_DIR}/ignore" /etc/git/ignore

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'git'"
