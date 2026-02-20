#!/usr/bin/env fish

if not status is-interactive; or not type -q wezterm
    exit
end

###############################################################################

function wezterm-lua
    $EDITOR $WEZTERM_CONFIG_FILE
end
