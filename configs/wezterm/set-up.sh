#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'wezterm'..."

link "${SCRIPT_DIR}/env.sh" "${XDG_CONFIG_HOME:-/.config}/fish/conf.d/wezterm-env.fish"
link "${SCRIPT_DIR}/env.sh" "${XDG_CONFIG_HOME:-/.config}/posix/wezterm.sh"
link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-/.config}/fish/conf.d/wezterm-shell.fish"
link "${SCRIPT_DIR}/wezterm.lua" /etc/wezterm/wezterm.lua

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'wezterm'"
