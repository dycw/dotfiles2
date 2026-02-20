#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

link_home() {
	home="$1"
	link_home_one "${SCRIPT_DIR}/.tmux/.tmux.conf" "${home}" tmux.conf
	link_home_one "${SCRIPT_DIR}/tmux.conf.local" "${home}" tmux.conf.local
}

link_home_one() {
	src="$1"
	home="$2"
	dest="$3"
	target="${home}/.config/tmux/${dest}"
	link "${src}" "${target}"
	owner=$(stat -c '%U:%G' "${home}" 2>/dev/null || echo '')
	[ -n "${owner}" ] && chown -h "${owner}" "${target}" 2>/dev/null || :
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'tmux'..."

link_home "${HOME}"
if [ -d /home ]; then
	for dir in /home/*; do
		link_home "${dir}"
	done
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'tmux'"
