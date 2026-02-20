#!/usr/bin/env fish

if not status is-interactive; or not type -q prek
    exit
end

###############################################################################

function pg
    for i in (seq 1 3)
        __prek_auto_update
        __prek_run
        if type -q __git_all
            __git_all
        end
        if test $status -eq 0
            return 0
        end
    end
end
function pr
    __prek_run
end
function prf
    rm -rf "$HOME/.cache/pre-commit-hooks/throttle"
    __prek_run
end
function pri
    prek install --overwrite --install-hooks
end
function pru
    prek uninstall
end
function pu
    __prek_auto_update
end
function pur
    __prek_auto_update
    __prek_run
    if type -q __git_all
        __git_all
    end
end
function __prek_auto_update
    prek auto-update --jobs=10 --verbose
end
function __prek_run
    prek run --all-files --show-diff-on-failure --quiet
end
