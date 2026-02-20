#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'fzf'..."

link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/fzf.fish"
link "${SCRIPT_DIR}/shell.sh" "${XDG_CONFIG_HOME:-${HOME}/.config}/posix/fzf.sh"
link "${SCRIPT_DIR}/fzf.fish/conf.d/fzf.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/fzf-fish-plugin.fish"
for file in "${SCRIPT_DIR}"/fzf.fish/functions/*.fish; do
	[ -e "$file" ] || continue
	name=$(basename -- "${file}")
	link "${file}" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/functions/${name}"
done
