#!/usr/bin/env fish

fzf --fish | source
if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\ct --git_log= --git_status= \
        --history=\cr --processes=\cp --variables=\ce
end
