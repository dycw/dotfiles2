#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac || ! command -v rg >/dev/null 2>&1; then
	exit 0
fi

###############################################################################

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}/ripgrep/ripgreprc"
