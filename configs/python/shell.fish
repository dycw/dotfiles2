#!/usr/bin/env fish

if not status is-interactive
    exit
end

#### coverage #################################################################

function coverage
    open .coverage/html/index.html
end

#### pyright/pytest ###########################################################

function pyrt
    __pyright $argv; or return $status
    pytest --numprocesses auto $argv
end

function pyrtf
    set -l n 5
    while true
        if type -q pyright; or type -q uv
            while not __pyright $argv
                sleep $n
            end
        else
            echo "'pyrtf' expected 'pyright' to be available" >&2; and return 1
        end
        sleep $n
        if type -q pytest
            while not pytest --numprocesses auto $argv
                sleep $n
            end
        else
            echo "'pyrtf' expected 'pytest' to be available" >&2; and return 1
        end
        sleep $n
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
