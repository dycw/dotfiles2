#!/usr/bin/env fish

if not status is-interactive; or not type -q btm
    exit
end

###############################################################################

function bottom-toml
    "$EDITOR" "$HOME/.config/bottom/bottom.toml"
end
