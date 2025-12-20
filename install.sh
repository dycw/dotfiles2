#!/usr/bin/env sh

echo "Running installer..."

if [ $(hostname) = RH-MacBook ]; then
    echo "Running installer for 'RH-MacBook'..."
    ./scripts/setup-uv.sh
    ./scripts/rh-macbook.py
fi
