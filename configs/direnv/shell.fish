#!/usr/bin/env fish

if not status is-interactive; or not type -q direnv
    exit
end

direnv hook fish | source

function dea
    direnv allow .
end
