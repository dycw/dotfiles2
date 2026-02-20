#!/usr/bin/env sh
# shellcheck disable=SC1090

set -eu

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up '$(hostname)'..."

script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
sh "${script_dir}/_lib/install.sh"

configs="$(dirname -- "${script_dir}")/configs"
find "${configs}" -type f -name set-up.sh | sort | while IFS= read -r script; do
	sh "${script}"
done
