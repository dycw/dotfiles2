#!/usr/bin/env sh

echo "Running installer..."

if [ $(hostname) = RH-MacBook ]; then
    echo "Running installer for 'RH-MacBook'..."
    ./entrypoints/rh-macbook.py
fi
