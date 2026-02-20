#!/usr/bin/env sh
# shellcheck disable=SC1091,SC2016

set -eu

#### check system #############################################################

if [ ! -r /etc/os-release ]; then
	echo "'/etc/os-release' is not readable; exiting..." >&2
	exit 1
fi
. /etc/os-release
if [ "${ID:-}" != debian ]; then
	echo "'ID' (${ID:-}) is not Debian; exiting..." >&2
	exit 1
fi

#### fix 'apt' sources ########################################################

tee /etc/apt/sources.list >/dev/null <<'EOF'
deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
EOF

#### set up SSH ###############################################################

uvx --from dycw-installer[cli]@latest set-up-ssh
uvx --from dycw-installer[cli]@latest set-up-sshd --permit-root-login

#### install & set up 'neovim' ################################################

uvx --from dycw-installer[cli]@latest set-up-neovim
rm -rf ~/.config/nvim
git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim

#### set up 'derek' ###########################################################

cp ~/.ssh/authorized_keys /home/derek/.ssh/authorized_keys
su -s /bin/bash - derek <<'EOF'
set -eu
curl -LsSf https://astral.sh/uv/install.sh | sh
source ${HOME}/.local/bin/env
AUTHORIZED_KEYS='https://raw.githubusercontent.com/dycw/authorized-keys/refs/heads/master/authorized_keys'
uvx --from dycw-installer[cli]@latest set-up-keys "$(curl -fssL ${AUTHORIZED_KEYS})"
uvx --from dycw-installer[cli]@latest set-up-ssh
rm -rf ~/.config/nvim
git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim
EOF

#### exit #####################################################################

echo "'set-up-vm' finished; exiting..."
