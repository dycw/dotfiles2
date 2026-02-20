#!/usr/bin/env fish

if not status is-interactive; or not type -q tmux
    exit
end

###############################################################################

function ta
    if test (count $argv) -eq 0
        set -l count (tmux ls | wc -l)
        if test "$count" -eq 0
            tmux new
            return
        else if test "$count" -eq 1
            tmux attach
        else
            echo "'ta' expected [0..1] arguments SESSION; got $(count $argv)" >&2; and return 1
        end
    else
        tmux attach -t $argv[1]
    end
end

function tmux-reload
    tmux source-file ${XDG_CONFIG_HOME}/tmux/tmux.conf
end
