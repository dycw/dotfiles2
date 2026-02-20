#!/usr/bin/env fish

if not status is-interactive; or not type -q bat
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

        # postgresql@17
        if test -d (brew --prefix postgresql@17)/bin
            fish_add_path (brew --prefix postgresql@17)/bin
        end
    end

    # node
end
