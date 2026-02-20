#!/usr/bin/env sh

export PATH_DOTFILES=/etc/dotfiles

#### swap files ###############################################################

for swap in "${HOME}"/.mode.sw*; do
	[ -e "${swap}" ] || continue
	rm -v -- "${swap}"
done
