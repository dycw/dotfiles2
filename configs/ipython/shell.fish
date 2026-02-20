#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

function ipython-startup
    $EDITOR $HOME/dotfiles/ipython/startup.py
end
