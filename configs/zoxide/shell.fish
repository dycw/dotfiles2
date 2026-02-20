#!/usr/bin/env fish

if not status is-interactive; or not type -q zoxide
    exit
end

zoxide init --cmd j fish | source
