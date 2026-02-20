#!/usr/bin/env sh

if [ -z "${PS1-}" ] || ! command -v starship >/dev/null 2>&1; then
	exit
fi

###############################################################################

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(starship init bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(starship init zsh)"
fi
