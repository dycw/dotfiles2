#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'pytest'..."

link "${SCRIPT_DIR}/shell.fish" /etc/fish/conf.d/pytest-fish.fish
link "${SCRIPT_DIR}/shell.sh" /etc/fish/conf.d/pytest-common.fish
link "${SCRIPT_DIR}/shell.sh" /etc/profile.d/pytest.sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'pytest'"
