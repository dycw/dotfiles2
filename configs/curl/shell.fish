#!/usr/bin/env fish

if ! status is-interactive
    exit
end

if type -q curl
    function curl-sh
        if test (count $argv) -lt 1
            echo "'curl-sh' expected [1..) arguments URL; got $(count $argv)" >&2; and return 1
        end
        curl -fsSL $argv[1] | sh -s -- $argv[2..]
    end
    function curl-ip
        curl api.ipify.org
    end
end
