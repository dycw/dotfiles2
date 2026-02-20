#!/usr/bin/env sh

###############################################################################

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'fzf'..."

link "${SCRIPT_DIR}/fzf.fish" /etc/fish/conf.d/fzf.sh
link "${SCRIPT_DIR}/fzf.sh" /etc/profile.d/fzf.sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'fzf'"
