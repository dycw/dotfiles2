#!/usr/bin/env fish

direnv hook fish | source

if ! status is-interactive
    exit
end

if type -q direnv
    function dea
        direnv allow .
    end
end
