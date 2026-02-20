#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'zoxide'..."

link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-/.config}/fish/conf.d/zoxide.fish"
link "${SCRIPT_DIR}/shell.sh" "${XDG_CONFIG_HOME:-/.config}/posix/zoxide.sh"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'zoxide'"
