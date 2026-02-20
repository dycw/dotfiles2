#!/usr/bin/env sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'starship'..."

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

link "${SCRIPT_DIR}/starship.fish" /etc/fish/conf.d/starship.sh
link "${SCRIPT_DIR}/starship.sh" /etc/profile.d/starship.sh
link "${SCRIPT_DIR}/starship.toml" /etc/starship/starship.toml

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'starship'"
