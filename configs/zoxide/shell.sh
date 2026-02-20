#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac || ! command -v zoxide >/dev/null 2>&1; then
	exit 0
fi

###############################################################################

if [ -z "${PS1-}" ] || ! command -v zoxide >/dev/null 2>&1; then
	exit
fi

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(zoxide init --cmd j bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(zoxide init --cmd j zsh)"
fi
