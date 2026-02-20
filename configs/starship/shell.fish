#!/usr/bin/env fish

if not status is-interactive; or not type -q starship
    exit
end

###############################################################################

export STARSHIP_CONFIG='/etc/starship.toml'

starship init fish | source
