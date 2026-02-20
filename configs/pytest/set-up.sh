#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'pytest'..."

link "${SCRIPT_DIR}/env.sh" "${XDG_CONFIG_HOME:-/.config}/fish/conf.d/pytest-env.fish"
link "${SCRIPT_DIR}/env.sh" /etc/profile.d/pytest.sh
link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-/.config}/fish/conf.d/pytest-shell.fish"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'pytest'"
