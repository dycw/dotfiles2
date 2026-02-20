#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac then
	exit 0
fi

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
	ln -sfn "${script_dir}/$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'pdb'..."

link pdbrc "${HOME}/.pdbrc"
