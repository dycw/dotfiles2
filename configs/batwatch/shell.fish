#!/usr/bin/env fish

if not status is-interactive; or not type -q batwatch
    exit
end

###############################################################################

function bw
    batwatch -n0.5 $argv
end
