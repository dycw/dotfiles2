#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac || ! command -v starship >/dev/null 2>&1; then
	exit 0
fi

###############################################################################

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(starship init bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(starship init zsh)"
fi
