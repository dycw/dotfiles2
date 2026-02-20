#!/usr/bin/env sh

set -eu
case $- in
*i*) ;;
*) return ;;
esac

###############################################################################

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}/ripgrep/ripgreprc"
