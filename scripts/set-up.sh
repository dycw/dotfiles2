#!/usr/bin/env sh
# shellcheck disable=SC1090

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up '$(hostname)'..."

configs="$(dirname -- "${SCRIPT_DIR}")/configs"
find "${configs}" -type f -name 'set-up.sh' | while IFS= read -r script; do
	. "${script}"
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up '$(hostname)'..."
