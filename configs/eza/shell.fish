#!/usr/bin/env fish

if not status is-interactive; or not type -q eza
    exit
end

###############################################################################

function l
    la --git-ignore $argv
end

function la
    eza --all --classify=always --git --group --group-directories-first \
        --header --long --time-style=long-iso $argv
end

function wl
    watch --color --differences --interval=1 -- \
        eza --all --classify=always --color=always --git --group \
        --group-directories-first --header --long --reverse \
        --sort=modified --time-style=long-iso $argv
end
