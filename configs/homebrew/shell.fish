#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

if test -d /opt/homebrew/bin
    fish_add_path /opt/homebrew/bin

    if type -q brew
        brew shellenv | source

        # node
        if test -d (brew --prefix node)/bin
            fish_add_path (brew --prefix node)/bin
        end
    end

    # node
end
