#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'bash'..."

link "${SCRIPT_DIR}/shell.fish" /etc/fish/conf.d/bash.fish
link "${SCRIPT_DIR}"/bash_config.py \
	"${HOME}"/.bash/profile_default/bash_config.py
link "${SCRIPT_DIR}"/startup.py \
	"${HOME}"/.bash/profile_default/startup/startup.py

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'bash'"
