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

link "${SCRIPT_DIR}/env.sh" /etc/fish/conf.d/starship-env.fish
link "${SCRIPT_DIR}/env.sh" /etc/profile.d/starship-env.sh
link "${SCRIPT_DIR}/shell.fish" /etc/fish/conf.d/starship-shell.fish
link "${SCRIPT_DIR}/shell.sh" /etc/profile.d/starship-shell.sh
link "${SCRIPT_DIR}/starship.toml" /etc/starship/starship.toml

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'starship'"
