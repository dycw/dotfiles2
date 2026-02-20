#!/usr/bin/env sh

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

ln -sfn "${SCRIPT_DIR}/starship.toml" /etc/starship/starship.toml
