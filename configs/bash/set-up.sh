#!/usr/bin/env sh

set -eu

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
	ln -sfn "${script_dir}/$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'bash'..."

link bashrc "${HOME}/.bashrc"
