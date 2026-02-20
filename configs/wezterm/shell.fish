#!/usr/bin/env fish

if not status is-interactive; or not type -q wezterm
    exit
end

###############################################################################

function edit-wezterm-lua
    $EDITOR $PATH_DOTFILES/configs/wezterm/wezterm.lua
end
