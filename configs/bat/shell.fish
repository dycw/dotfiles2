#!/usr/bin/env fish

if ! status is-interactive
    exit
end

if type -q bat
    function cat
        bat $argv
    end
    function catp
        bat --style=plain $argv
    end
end
