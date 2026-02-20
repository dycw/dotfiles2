#!/usr/bin/env sh

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(fzf --bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(fzf --zsh)"
fi
