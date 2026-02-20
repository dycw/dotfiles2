#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'ripgrep'..."

link "${SCRIPT_DIR}/ripgreprc" "${XDG_CONFIG_HOME:-\$\{HOME\}/.config}/ripgrep/ripgreprc"
link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-\$\{HOME\}/.config}/fish/conf.d/ripgrep.fish"
link "${SCRIPT_DIR}/shell.sh" "${XDG_CONFIG_HOME:-\$\{HOME\}/.config}/posix/ripgrep.sh"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'ripgrep'"
