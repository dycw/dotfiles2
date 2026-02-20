#!/usr/bin/env fish

if not status is-interactive; or not type -q ghostty
    exit
end

fzf --fish | source

set fzf_fd_opts --hidden
set fzf_history_time_format '%Y-%m-%d %H:%M:%S (%a)'

if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\ct --git_log= --git_status= \
        --history=\cr --processes=\cp --variables=\ce
end
