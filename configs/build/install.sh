#!/usr/bin/env sh

set -eu

###############################################################################

case "$1" in
debian)
	if command -v cc >/dev/null 2>&1; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'build-essential' is already installed"
	else
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'build-essential'..."
		if [ "$(id -u)" -eq 0 ]; then
			apt install -y build-essential
		else
			sudo apt install -y build-essential
		fi
	fi

	if command -v pg_config >/dev/null 2>&1; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'libpq-dev' is already installed"
	else
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'libpq-dev'..."
		if [ "$(id -u)" -eq 0 ]; then
			apt install -y libpq-dev
		else
			sudo apt install -y libpq-dev
		fi
	fi
	;;
macmini)
	if command -v autoconf >/dev/null 2>&1; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'autoconf' is already installed"
	else
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'autoconf'..."
		brew install autoconf
	fi

	if command -v automake >/dev/null 2>&1; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'automake' is already installed"
	else
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'automake'..."
		brew install automake
	fi
	;;
*) ;;
esac
