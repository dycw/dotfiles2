#!/usr/bin/env sh

set -eu

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'ssh'..."

if ! [ -f "${HOME}/.ssh/authorized_keys" ]; then
	AUTHORIZED_KEYS='https://raw.githubusercontent.com/dycw/authorized-keys/refs/heads/master/authorized_keys'
	uvx --from dycw-installer[cli]@latest set-up-keys "$(curl -fssL ${AUTHORIZED_KEYS})"
fi

if ! [ -d "${HOME}/.ssh/config.d" ]; then
	echo 2
	uvx --from dycw-installer[cli]@latest set-up-ssh
fi
