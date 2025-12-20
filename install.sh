#!/usr/bin/env sh

# echo
echo_date() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2; }

# main
echo_date "Running installer..."

if [ $(hostname) = RH-MacBook ]; then
    echo_date "This is 'RH-MacBook'; running installer for 'RH-MacBook'..."
    ./scripts/setup-uv.sh
    ./scripts/uv/rh-macbook.py
fi
