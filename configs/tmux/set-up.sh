#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

link_home() {
	home="$1"
}

link_home_one() {
	src="$1"
	home="$2"
	dest="$3"
	target="${home}"/.config/tmux/"${dest}"
	link "${src}" "${target}"
	owner=$(stat -c '%U:%G' "${home}" 2>/dev/null || echo '')
	[ -n "${owner}" ] && chown -h "${owner}" "${target}" 2>/dev/null || :
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'tmux'..."

link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/tmux.fish"
link "${SCRIPT_DIR}/tmux.conf.local" "${XDG_CONFIG_HOME:-${HOME}/.tmux}/tmux/tmux.conf.local"
link "${SCRIPT_DIR}/.tmux/.tmux.conf" "${XDG_CONFIG_HOME:-${HOME}/.tmux}/tmux/tmux.conf"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'tmux'"
