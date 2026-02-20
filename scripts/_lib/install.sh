#!/usr/bin/env sh
# shellcheck disable=SC1091,SC2016

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing apps on '$(hostname)'..."

unset system
if [ "$(uname)" = Linux ] && [ -r /etc/os-release ]; then
	. /etc/os-release
	if [ "${ID:-}" = debian ]; then
		system=debian
	fi
elif [ "$(uname)" = Darwin ]; then
	model=$(system_profiler SPHardwareDataType | awk -F': ' '/Model Identifier/ {print $2}')
	case "${model}" in
	Mac14,12 | Mac14,3) system=macmini ;;
	MacBook*) system=macbook ;;
	*) ;;
	esac
fi
case "${system:-}" in
debian) sh "${SCRIPT_DIR}"/install-debian.sh ;;
macmini)
	if command -v brew >/dev/null 2>&1; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'brew' is already installed"
	else
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'brew'..."

		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	;;
macbook) sh "${SCRIPT_DIR}"/install-macbook.sh ;;
*)
	echo "Unsupported system '${system}'; exiting..." >&2
	exit 1
	;;
esac

configs="$(dirname -- "$(dirname -- "${SCRIPT_DIR}")")"/configs
find "${configs}" -type f -name 'install.sh' ! -path "${configs}/tmux/.tmux/*" | sort | while IFS= read -r script; do
	sh "${script}" "${system}"
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished installing apps on '$(hostname)'..."
