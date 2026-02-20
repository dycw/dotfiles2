#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'starship'..."

link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/starship.fish"
link "${SCRIPT_DIR}/shell.sh" "${XDG_CONFIG_HOME:-${HOME}/.config}/posix/starship.sh"
link "${SCRIPT_DIR}/starship.toml" "${XDG_CONFIG_HOME:-${HOME}/.config}/starship.toml"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'starship'"
