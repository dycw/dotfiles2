#!/usr/bin/env fish

if not status is-interactive; or not type -q fd
    exit
end

function fdd
    __fd_base directory $argv
end

function fdf
    __fd_base file $argv
end

function __fd_base
    if test (count $argv) -lt 1
        echo "'__fd_base' expected [1..) arguments TYPE; got $(count $argv)" >&2; and return 1
    end
    fd --hidden --type=$argv[1] $argv[2..]
end
