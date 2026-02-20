#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

function ipython-startup
    $EDITOR $PATH_DOTFILES/configs/ipython/startup.py
end
