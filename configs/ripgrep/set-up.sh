#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'ripgrep'..."

link "${SCRIPT_DIR}/shell.sh" /etc/fish/conf.d/ripgrep.fish
link "${SCRIPT_DIR}/shell.sh" /etc/profile.d/ripgrep.sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'ripgrep'"
