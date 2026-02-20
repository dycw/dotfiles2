#!/usr/bin/env sh

if [ -n "${BASH_VERSION-}" ]; then
	eval "$(zoxide init --cmd j bash)"
elif [ -n "${ZSH_VERSION-}" ]; then
	eval "$(zoxide init --cmd j zsh)"
fi
