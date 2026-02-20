#!/usr/bin/env fish

if not status is-interactive; or not begin
        type -q fd; or type -q fdfind
    end
    exit
end

###############################################################################

if type -q fdfind and not type -q fd
    function fd
        __fd $argv
    end
end

function fdd
    __fd_type directory $argv
end

function fdf
    __fd_type file $argv
end

function __fd
    if type -q fd
        fd $argv
    else if type -q fdfind
        fdfind $argv
    else
        echo "'__fd' expected 'fd' or 'fdfind' to be available; got neither" >&2; and return 1
    end
end

function __fd_type
    if test (count $argv) -lt 1
        echo "'__fd_base' expected [1..) arguments TYPE; got $(count $argv)" >&2; and return 1
    end
    __fd --hidden --type=$argv[1] $argv[2..]
end
