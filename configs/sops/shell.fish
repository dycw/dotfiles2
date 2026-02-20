#!/usr/bin/env fish

if not status is-interactive; or not type -q sops
    exit
end

###############################################################################

function sops-new
    if test (count $argv) -lt 2
        echo "'sops-new' expected [2..] arguments AGE FILE; got $(count $argv)" >&2; and return 1
    end
    sops edit --age $argv[1] $argv[2]
end
