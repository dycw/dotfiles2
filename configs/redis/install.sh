#!/usr/bin/env sh

set -eu

###############################################################################

if command -v redis-cli >/dev/null 2>&1; then
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] 'redis' is already installed"
	exit
fi

case "$1" in
debian)
	if [ "$(id -u)" -eq 0 ]; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'redis'..."
		apt-get install lsb-release curl gpg
		curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
		chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list
		apt-get update
		apt-get install redis
	else
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'redis'..."
		sudo apt-get install lsb-release curl gpg
		curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
		sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
		sudo apt-get update
		sudo apt-get install redis
	fi
	;;
macmini)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installing 'redis'..."
	brew install redis-stack --cask
	brew services start redis
	;;
*) ;;
esac
