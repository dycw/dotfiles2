#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
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

if command -v fish >/dev/null 2>&1 && ${USER_SHELL} != "$(which fish)"; then
	chsh -s "$(which fish)"
fi
link "${SCRIPT_DIR}/shell.fish" "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/conf.d/fish.fish"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'fish'"
