#!/usr/bin/env sh

# https://ghostty.org/docs/help/terminfo#ssh
brew install ncurses
/usr/local/opt/ncurses/bin/infocmp -x xterm-ghostty | ssh dw-mac -- tic -x -
