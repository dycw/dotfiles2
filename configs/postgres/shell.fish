#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

if test -d /opt/homebrew/opt/postgresql@18/bin
    fish_add_path /opt/homebrew/opt/postgresql@18/bin
end
