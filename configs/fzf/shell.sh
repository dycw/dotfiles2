#!/usr/bin/env sh

if [ -z "${PS1-}" ] || ! command -v fzf >/dev/null 2>&1; then
	exit
fi

###############################################################################

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(fzf --bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(fzf --zsh)"
fi
