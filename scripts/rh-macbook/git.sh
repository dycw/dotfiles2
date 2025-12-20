#!/usr/bin/env sh

(
    cd $(git rev-parse --show-toplevel) && \
    git add . && \
    git commit -m asdf --no-verify && \
    git push
)
