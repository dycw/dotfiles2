#!/usr/bin/env fish

if not status is-interactive; or not type -q asciinema
    exit
end

function asciinema-record
    set -l dir
    if test -d $HOME/Dropbox/Screenshots
        set dir $HOME/Dropbox/Screenshots
    else
        set dir (pwd)
    end
    set -l now (date -u +"%Y-%m-%dT%H-%M-%S-UTC")
    set -l path_tmp $dir/$now.asciinema
    asciinema record $path_tmp
    if type -q agg
        agg $path_tmp $dir/$now.gif
        rm $path_tmp
    end
end
