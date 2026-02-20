#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

if test -f $HOME/work/qrt-dotfiles/fish/config.fish
    source $HOME/work/qrt-dotfiles/fish/config.fish
end
