#!/usr/bin/env fish

if not status is-interactive; or not type -q vim
    exit
end

###############################################################################

function v
    vim $argv
end
