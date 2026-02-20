#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

link_home() {
	home="$1"
	target="${home}/.config/bottom/bottom.toml"
	link "${SCRIPT_DIR}/bottom.toml" "${target}"
	owner=$(stat -c '%U:%G' "${home}" 2>/dev/null || echo '')
	[ -n "${owner}" ] && chown -h "${owner}" "${target}" 2>/dev/null || :
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'bottom'..."

link_home "${HOME}"
if [ -d /home ]; then
	for dir in /home/*; do
		link_home "${dir}"
	done
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'bottom'"
