#!/usr/bin/env sh

set -eu

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
	ln -sfn "${script_dir}1" "${XDG_CONFIG_HOME:-${HOME}/.config}/$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'fish'..."

case "$(uname -s)" in
Darwin)
	USER_SHELL=$(dscl . -read "/Users/${USER}" UserShell | awk '{print $2}')
	;;
Linux)
	USER_SHELL=$(getent passwd "${USER}" | cut -d: -f7)
	;;
*)
	echo "Unsupported OS '$(uname -s)'; exiting..." >&2
	exit 1
	;;
esac

if command -v fish >/dev/null 2>&1 && [ "${USER_SHELL}" != "$(which fish)" ]; then
	chsh -s "$(which fish)"
fi
link shell.fish fish/conf.d/fish.fish
