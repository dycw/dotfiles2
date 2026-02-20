#!/usr/bin/env fish

if not status is-interactive; or not begin
        type -q fd; or type -q fdfind
    end
    exit
end

###############################################################################

if type -q fdfind and not type -q fd
    function fd
        fdfind $argv
    end
end

function fdd
    __fd_type directory $argv
end

function fdf
    __fd_type file $argv
end

function __fd_type
    if test (count $argv) -lt 1
        echo "'__fd_type' expected [1..) arguments TYPE; got $(count $argv)" >&2; and return 1
    end
    fd --hidden --type=$argv[1] $argv[2..]
end
