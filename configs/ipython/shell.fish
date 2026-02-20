#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

function edit-ipython-startup
    $EDITOR $PATH_DOTFILES/configs/ipython/startup.py
end
