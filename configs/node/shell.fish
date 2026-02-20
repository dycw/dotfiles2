#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

if test -d /opt/homebrew/opt/node/bin
    fish_add_path /opt/homebrew/opt/node/bin
end
