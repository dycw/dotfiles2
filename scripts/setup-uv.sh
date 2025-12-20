#!/usr/bin/env sh

# echo
echo_date() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2; }

# main
if command -v uv >/dev/null 2>&1; then
    echo_date "'uv' is already installed"
else
    echo_date "Installing 'uv'..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo_date "Finished installing 'uv'"
fi
