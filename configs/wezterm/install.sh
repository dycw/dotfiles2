#!/usr/bin/env sh

set -eu

###############################################################################

if command -v wezterm >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'wezterm' is already installed"
	exit
fi

case "$1" in
debian)
	if [ "$(id -u)" -eq 0 ]; then
		curl -fsSL https://apt.fury.io/wez/gpg.key | gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
		echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | tee /etc/apt/sources.list.d/wezterm.list
		chmod 644 /usr/share/keyrings/wezterm-fury.gpg
		apt update
		apt install wezterm
	else
		curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
		echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
		sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
		sudo apt update
		sudo apt install wezterm
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'wezterm'..."
	brew install wezterm --cask
	;;
*) ;;
esac
