#!/usr/bin/env sh
# shellcheck disable=SC1090

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up '$(hostname)'..."

sh "${SCRIPT_DIR}"/_lib/install.sh

configs="$(dirname -- "${SCRIPT_DIR}")"/configs
find "${configs}" -type f -name 'set-up.sh' | sort | while IFS= read -r script; do
	sh "${script}"
done
