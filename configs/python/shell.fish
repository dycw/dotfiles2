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

#### python ###################################################################

function p3
    python3 $argv
end

function p3pdb
    if test (count $argv) -eq 0
        echo "'p3pdb' expected [1..) arguments EXECUTABLE; got $(count $argv)" >&2; and return 1
    end
    python -m pdb -c continue "$(which $argv[1])" argv[2..]
end
