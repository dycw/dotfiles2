#!/usr/bin/env sh

#### editor ###################################################################

if command -v nvim >/dev/null 2>&1; then
	export EDITOR=nvim
	export VISUAL=nvim
elif command -v vim >/dev/null 2>&1; then
	export EDITOR=vim
	export VISUAL=vim
elif command -v vi >/dev/null 2>&1; then
	export EDITOR=vi
	export VISUAL=vi
elif command -v nano >/dev/null 2>&1; then
	export EDITOR=nano
	export VISUAL=nano
fi

#### swap files ###############################################################

for swap in "$HOME"/.mode.sw*; do
	[ -e "$swap" ] || continue
	rm -v -- "$swap"
done
