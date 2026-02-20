#!/usr/bin/env fish

direnv hook fish | source

if type -q direnv
    function dea
        direnv allow .
    end
end
