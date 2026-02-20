#!/usr/bin/env sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'bottom'..."

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

link() {
	home="$1"
	target="${home}/.config/bottom/bottom.toml"
	mkdir -p "$(dirname -- "${target}")"
	ln -sfn "${SCRIPT_DIR}/bottom.toml" "${target}"
	owner=$(stat -c '%U:%G' "${home}" 2>/dev/null || echo '')
	[ -n "${owner}" ] && chown -h "${owner}" "${target}" 2>/dev/null || :
}

link "${HOME}"
if [ -d /root ]; then
	link /root
fi
if [ -d /home ]; then
	for dir in /home/*; do
		link "${dir}"
	done
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'bottom'"
