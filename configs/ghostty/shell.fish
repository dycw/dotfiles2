#!/usr/bin/env fish

if not status is-interactive; or not type -q ghostty
    exit
end

function ghostty-config
    $EDITOR $HOME/dotfiles/ghostty/config
end
