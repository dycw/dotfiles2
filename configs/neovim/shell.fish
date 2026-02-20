#!/usr/bin/env fish

if not status is-interactive; or not type -q nvim
    exit
end

###############################################################################

function n
    nvim $argv
end
