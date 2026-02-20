#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac then
	exit 0
fi

###############################################################################

# https://ghostty.org/docs/help/terminfo#ssh
brew install ncurses
/usr/local/opt/ncurses/bin/infocmp -x xterm-ghostty | ssh dw-mac -- tic -x -
