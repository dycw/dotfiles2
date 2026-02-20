#!/usr/bin/env sh

###############################################################################

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'fzf'..."

link "${SCRIPT_DIR}/shell.fish" /etc/fish/conf.d/fzf.fish
link "${SCRIPT_DIR}/shell.sh" /etc/profile.d/fzf.sh
link "${SCRIPT_DIR}/fzf.fish/conf.d/fzf.fish" /etc/fish/conf.d/fzf-fish-plugin.fish
for file in "${SCRIPT_DIR}"/fzf.fish/functions/*.fish; do
	[ -e "$file" ] || continue
	name=$(basename -- "${file}")
	link "${file}" "/etc/fish/functions/${name}"
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'fzf'"
