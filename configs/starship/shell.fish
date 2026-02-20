#!/usr/bin/env fish

if not status is-interactive; or not type -q starship
    exit
end

###############################################################################

starship init fish | source
