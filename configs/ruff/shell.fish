#!/usr/bin/env fish

if not status is-interactive; or not type -q ruff
    exit
end

###############################################################################

function rw
    ruff check -w $argv
end
