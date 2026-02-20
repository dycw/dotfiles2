#!/usr/bin/env fish

if not status is-interactive; or not type -q btm
    exit
end

###############################################################################

function bottom-toml
    $EDITOR $PATH_DOTFILES/configs/bottom/bottom.toml
end
