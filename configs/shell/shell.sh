#!/usr/bin/env sh

set -eu

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

#### local ####################################################################

if [ -d "${HOME}"/.local/bin ]; then
	export PATH="${HOME}/.local/bin${PATH:+:${PATH}}"
fi

#### swap files ###############################################################

for swap in "${HOME}"/.mode.sw*; do
	[ -e "${swap}" ] || continue
	rm -v -- "${swap}"
done

#### XDG ######################################################################

export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
