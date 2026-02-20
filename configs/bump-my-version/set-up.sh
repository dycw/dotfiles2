#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'bump-my-version'..."

link "${SCRIPT_DIR}/shell.fish" /etc/fish/conf.d/bump-my-version.fish

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'bump-my-version'"
