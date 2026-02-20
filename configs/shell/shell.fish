#!/usr/bin/env fish

#### swap files ###############################################################

for swap in $HOME/.mode.sw*
    command rm -v $swap
end
