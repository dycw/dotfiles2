#!/usr/bin/env fish

if ! status is-interactive
    exit
end

function bottom-toml
    "$EDITOR" "$HOME/.config/bottom/bottom.toml"
end
