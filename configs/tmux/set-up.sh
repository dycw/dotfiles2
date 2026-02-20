#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'tmux'..."

link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/tmux.fish"
link "${SCRIPT_DIR}/tmux.conf.local" "${XDG_CONFIG_HOME:-${HOME}/.tmux}/tmux/tmux.conf.local"
link "${SCRIPT_DIR}/.tmux/.tmux.conf" "${XDG_CONFIG_HOME:-${HOME}/.tmux}/tmux/tmux.conf"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'tmux'"
