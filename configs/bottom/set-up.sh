#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'bottom'..."

link "${SCRIPT_DIR}/bottom.toml" "${XDG_CONFIG_HOME:-/.config}/bottom/bottom.toml"
link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-/.config}/fish/conf.d/bottom.fish"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'bottom'"
