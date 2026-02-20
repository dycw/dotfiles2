#!/usr/bin/env sh

set -eu

###############################################################################

script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "${XDG_CONFIG_HOME:-${HOME}/.config}/$2"
}

link_here() {
	link_plain "${script_dir}/$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'fzf'..."

link_here shell.fish fish/conf.d/fzf.fish
link_here shell.sh posix/fzf.sh
link_here fzf.fish/conf.d/fzf.fish fish/conf.d/fzf-fish-plugin.fish
for file in "${script_dir}"/fzf.fish/functions/*.fish; do
	[ -e "$file" ] || continue
	name=$(basename -- "${file}")
	link "${file}" "fish/functions/${name}"
done
