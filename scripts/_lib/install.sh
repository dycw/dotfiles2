#!/usr/bin/env sh
# shellcheck disable=SC1091,SC2016

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

#### start ####################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing apps on '$(hostname)'..."

#### determine system #########################################################

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

#### per-system ###############################################################

case "${system:-}" in
debian)
	if command -v curl >/dev/null 2>&1; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'curl' is already installed"
	else
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'curl'..."
		if [ "$(id -u)" -eq 0 ]; then
			apt install -y curl
		else
			sudo apt install -y curl
		fi
	fi
	;;
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

#### uv #######################################################################

if command -v uv >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'uv' is already installed"
else
	case "${system:-}" in
	debian)
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'uv'..."
		if [ "$(id -u)" -eq 0 ]; then
			uv -LsSf https://astral.sh/uv/install.sh |
				UV_INSTALL_DIR=/usr/local/bin UV_NO_MODIFY_PATH=1 sh
		else
			curl -LsSf https://astral.sh/uv/install.sh |
				sudo UV_INSTALL_DIR=/usr/local/bin UV_NO_MODIFY_PATH=1 sh
		fi
		;;
	macmini | macbook)
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'uv'..."
		brew install uv
		;;
	esac
fi

#### sub-installers ###########################################################

configs="$(dirname -- "$(dirname -- "${SCRIPT_DIR}")")"/configs
find "${configs}" -type f -name 'install.sh' ! -path "${configs}/tmux/.tmux/*" | sort | while IFS= read -r script; do
	sh "${script}" "${system}"
done

#### finish ###################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished installing apps on '$(hostname)'..."
