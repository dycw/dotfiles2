#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'git'..."

link "${SCRIPT_DIR}/config" "${XDG_CONFIG_HOME:-${HOME}/.config}/git/config"
link "${SCRIPT_DIR}/ignore" "${XDG_CONFIG_HOME:-${HOME}/.config}/git/ignore"
link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/git.fish"
