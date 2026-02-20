#!/usr/bin/env sh

###############################################################################

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'zoxide'..."

link "${SCRIPT_DIR}/zoxide.fish" /etc/fish/conf.d/zoxide.sh
link "${SCRIPT_DIR}/zoxide.sh" /etc/profile.d/zoxide.sh

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'zoxide'"
