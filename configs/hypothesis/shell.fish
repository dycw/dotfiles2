#!/usr/bin/env fish

if not status is-interactive
    exit
end

###############################################################################

function hypothesis-ci
    export HYPOTHESIS_PROFILE=ci
end

function hypothesis-default
    export HYPOTHESIS_PROFILE=default
end

function hypothesis-dev
    export HYPOTHESIS_PROFILE=dev
end
