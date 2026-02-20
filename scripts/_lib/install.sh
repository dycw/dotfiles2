#!/usr/bin/env sh
# shellcheck disable=SC1091,SC2016

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Install apps on'$(hostname)'..."

unset SYSTEM
if [ -r /etc/os-release ]; then
	. /etc/os-release
	if [ "${ID:-}" != debian ]; then
		echo "'ID' (${ID:-}) is not Debian; exiting..." >&2
		exit 1
	fi
	exit 1
fi

sh "${SCRIPT_DIR}"/_lib/install.sh

configs="$(dirname -- "${SCRIPT_DIR}")"/configs
find "${configs}" -type f -name 'set-up.sh' | sort | while IFS= read -r script; do
	sh "${script}"
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished install apps '$(hostname)'..."
