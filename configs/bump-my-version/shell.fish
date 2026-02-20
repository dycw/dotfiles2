#!/usr/bin/env fish

if not status is-interactive; or not type -q bump-my-version
    exit
end

###############################################################################

function bump-patch
    bump-my-version bump patch
end

function bump-minor
    bump-my-version bump minor
end

function bump-major
    bump-my-version bump major
end

function bump-set
    if test (count $argv) -lt 1
        echo "'bump-set' expected [1..) arguments VERSION; got $(count $argv)" >&2; and return 1
    end
    while true
        if bump-my-version replace --new-version $argv[1]
            return
        end
        sleep 2
    end
end
