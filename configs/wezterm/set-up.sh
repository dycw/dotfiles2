#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'wezterm'..."

link "${SCRIPT_DIR}/shell.sh" /etc/fish/conf.d/wezterm.fish
link "${SCRIPT_DIR}/shell.sh" /etc/profile.d/wezterm.sh
link "${SCRIPT_DIR}/wezterm.lua" /etc/wezterm/wezterm.lua

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'wezterm'"
