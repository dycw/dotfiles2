#!/usr/bin/env sh

set -eu

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
	ln -sfn "${script_dir}1" "${XDG_CONFIG_HOME:-${HOME}/.config}/$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'pytest'..."

link env.sh fish/conf.d/pytest-env.fish
link env.sh posix/pytest.sh
link shell.fish fish/conf.d/pytest-shell.fish
