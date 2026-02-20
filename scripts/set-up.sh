#!/usr/bin/env sh
# shellcheck disable=SC1090

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up '$(hostname)'..."

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

configs="$(dirname -- "${SCRIPT_DIR}")/configs"
find "${configs}" -type f -name 'set-up.sh' | while IFS= read -r script; do
	. "${script}"
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up '$(hostname)'..."
