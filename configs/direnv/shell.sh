#!/usr/bin/env sh

if [ -z "${PS1-}" ] || ! command -v direnv >/dev/null 2>&1; then
	exit
fi

###############################################################################

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(direnv hook bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(direnv hook zsh)"
fi
