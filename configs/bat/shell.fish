#!/usr/bin/env fish

if not status is-interactive; or not begin
        type -q bat; or type -q batcat
    end
    exit
end

###############################################################################

if type -q batcat and not type -q bat
    function bat
        __bat $argv
    end
end

function cat
    __bat $argv
end

function catp
    __bat --style=plain $argv
end

function __bat
    if type -q bat
        bat $argv
    else if type -q batcat
        batcat $argv
    else
        echo "'__bat' expected 'bat' or 'batcat' to be available; got neither" >&2; and return 1
    end
end
