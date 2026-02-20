#!/usr/bin/env fish

fzf --fish | source

if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\ct --git_log= --git_status= \
        --history=\cr --processes=\cp --variables=\ce
end

if type -q fzf
    set fzf_fd_opts --hidden
    set fzf_history_time_format '%Y-%m-%d %H:%M:%S (%a)'
end
