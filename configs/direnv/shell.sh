#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac || ! command -v direnv >/dev/null 2>&1; then
	exit 0
fi

###############################################################################

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(direnv hook bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(direnv hook zsh)"
fi
