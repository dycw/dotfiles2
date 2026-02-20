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

if type -q batwatch
    function bw
        batwatch -n0.5 $argv
    end
end
