#!/usr/bin/env sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'bottom'..."

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

if [ -d /root ]; then
	link "${SCRIPT_DIR}/bottom.toml" /root/.config/bottom/bottom.toml
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'bottom'"
