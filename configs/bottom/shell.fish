#!/usr/bin/env fish

if not status is-interactive; or not type -q btm
    exit
end

###############################################################################

function edit-bottom-toml
    $EDITOR $PATH_DOTFILES/configs/bottom/bottom.toml
end
