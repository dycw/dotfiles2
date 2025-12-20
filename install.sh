#!/usr/bin/env sh

# echo
echo_date() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2; }

# main
echo_date "Running installer..."

LOCAL_BIN="${HOME}/.local/bin"
if [ $(hostname) = RH-MacBook ]; then
    echo_date "This is 'RH-MacBook'; running installer for 'RH-MacBook'..."
    ./scripts/setup-uv.sh
    PATH="${LOCAL_BIN}${PATH:+:${PATH}}" ./scripts/rh-macbook/script.py
    echo_date "Finished running installer for 'RH-MacBook'..."
else
    echo_date "Unknown hostname '$(hostname)'; exiting..." && exit 1
fi
