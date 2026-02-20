#!/usr/bin/env fish

if not status is-interactive; or not type -q rg
    exit
end

###############################################################################

if set -q XDG_CONFIG_HOME
    export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/ripgreprc
else
    export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/ripgreprc
end
