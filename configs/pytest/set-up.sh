#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'pytest'..."

link "${SCRIPT_DIR}/pytest.sh" /etc/fish/conf.d/pytest.sh
link "${SCRIPT_DIR}/pytest.sh" /etc/profile.d/pytest.sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'pytest'"
