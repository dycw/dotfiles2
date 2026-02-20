#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'ripgrep'..."

link "${SCRIPT_DIR}/env.sh" "${XDG_CONFIG_HOME:-/.config}/fish/conf.d/ripgrep.fish"
link "${SCRIPT_DIR}/env.sh" /etc/profile.d/ripgrep.sh
link "${SCRIPT_DIR}/ripgreprc" /etc/ripgrep/ripgreprc

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'ripgrep'"
