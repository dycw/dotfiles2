#!/usr/bin/env fish

if not status is-interactive; or not type -q pyright
    exit
end

###############################################################################

function pyr
    __pyright $argv
end

if type -q watchexec
    function wpyr
        set -l cmd "cd $(pwd); pyright"
        watchexec --exts json --exts py --exts toml --exts yaml --shell bash -- $cmd
    end
end

function __pyright
    if type -q pyright
        pyright .
    else if type -q uv
        set -l args
        if test -f .venv/bin/python
            set args $args --pythonpath .venv/bin/python
        end
        uv tool run pyright $args .
    else
        echo "'__pyright' expected 'pyright' or 'uv' to be available; got neither" >&2; and return 1
    end
end
