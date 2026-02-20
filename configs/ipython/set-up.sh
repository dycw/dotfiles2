#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'ipython'..."

link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/ipython.fish"
link "${SCRIPT_DIR}/ipython_config.py" "${HOME}/.ipython/profile_default/ipython_config.py"
link "${SCRIPT_DIR}/startup.py" "${HOME}/.ipython/profile_default/startup/startup.py"
