#!/usr/bin/env fish

if not status is-interactive; or not type -q ghostty
    exit
end

###############################################################################

function edit-ghostty-config
    $EDITOR $PATH_DOTFILES/configs/ghostty/config
end
