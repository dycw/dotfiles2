#!/usr/bin/env fish

if not status is-interactive; or not type -q uv; or not type -q uvx
    exit
end

###############################################################################

function ipy
    set -l args
    for arg in $argv
        set args $args --with $arg
    end
    uv run --with dycw-utilities --with ipython $args ipython
end

function jl
    set -l args
    for arg in $argv
        set args $args --with $arg
    end
    uv run --with dycw-utilities --with jupyterlab --with jupyterlab-vim $args jupyter lab
end

function pyc
    uvx pyclean --debris=all .
end

function uvbp
    if test (count $argv) -lt 1
        echo "'uvbp' accepts [1..) arguments TOKEN; got $(count $argv)" >&2; and return 1
    end
    uv build --wheel --clear
    uv publish --token $argv[1]
end

function uvl
    if test (count $argv) -eq 0
        uv pip list
    else
        uv pip list | grep -i $argv[1]
    end
end

function uvo
    uv pip list --outdated
end

function uvrp
    uv run python -m $argv
end

function uvrpd
    uv run python -m pdb --command continue -m $argv
end
