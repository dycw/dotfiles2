#!/usr/bin/env fish

if not status is-interactive; or not type -q bat
    exit
end

###############################################################################

function cat
    bat $argv
end

function catp
    bat --style=plain $argv
end
