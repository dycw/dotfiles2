#!/usr/bin/env sh

###############################################################################

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

link_home() {
	home="$1"
	target="${home}/.config/direnv/direnv.toml"
	link "${SCRIPT_DIR}/direnv.toml" "${target}"
	owner=$(stat -c '%U:%G' "${home}" 2>/dev/null || echo '')
	[ -n "${owner}" ] && chown -h "${owner}" "${target}" 2>/dev/null || :
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'direnv'..."

link "${SCRIPT_DIR}/shell.fish" /etc/fish/conf.d/direnv.fish
link "${SCRIPT_DIR}/shell.sh" /etc/profile.d/direnv.sh

link_home "${HOME}"
if [ -d /home ]; then
	for dir in /home/*; do
		link_home "${dir}"
	done
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'direnv'"
