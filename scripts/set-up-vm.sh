#!/usr/bin/env sh
# shellcheck disable=SC1091,SC2016
set -eu

# check system
if [ ! -r /etc/os-release ]; then
	echo "'/etc/os-release' is not readable; exiting..." >&2
	exit 1
fi
. /etc/os-release
if [ "${ID:-}" != debian ]; then
	echo "'ID' (${ID:-}) is not Debian; exiting..." >&2
	exit 1
fi

# fix 'apt' sources
tee /etc/apt/sources.list >/dev/null <<'EOF'
deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
EOF

# 'apt' installs
rm -rf /var/lib/apt/lists/*
apt update
apt full-upgrade -y
apt install -y age bat btm build-essential curl direnv du-dust eza fd-find \
	fish fzf git git-delta jq just restic ripgrep rsync sd shellcheck shfmt \
	starship sudo yq zoxide
apt autoremove -y
apt clean

chsh -s /usr/bin/fish
chsh -s /usr/bin/fish derek
usermod -aG sudo derek

# shell hooks
printf '%s\n' 'eval "$(direnv hook bash)"' >/etc/profile.d/direnv.sh
printf '%s\n' 'eval "$(fzf --bash)"' >/etc/profile.d/fzf.sh
printf '%s\n' 'eval "$(starship init bash)"' >/etc/profile.d/starship.sh
printf '%s\n' 'eval "$(zoxide init --cmd j bash)"' >/etc/profile.d/zoxide.sh

printf '%s\n' 'direnv hook fish | source' >/etc/fish/conf.d/direnv.fish
printf '%s\n' 'fzf --fish | source' >/etc/fish/conf.d/fzf.fish
printf '%s\n' 'starship init fish | source' >/etc/fish/conf.d/starship.fish
printf '%s\n' 'zoxide init --cmd j fish | source' >/etc/fish/conf.d/zoxide.fish

# install 'uv'
curl -LsSf https://astral.sh/uv/install.sh | sh
. "${HOME}/.local/bin/env"

# set up SSH
SSH_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFBGOo3yytWfRyOhsWIg4wR/s6wbxWM+MIWLV0EnlkJK'
uvx --from dycw-installer[cli]@latest set-up-keys "${SSH_KEY}"
uvx --from dycw-installer[cli]@latest set-up-ssh
uvx --from dycw-installer[cli]@latest set-up-sshd --permit-root-login

# install & set up 'neovim'
uvx --from dycw-installer[cli]@latest set-up-neovim
git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim
nvim --headless +Lazy! sync +qa

# set up 'derek'
su -s /bin/sh - derek <<'EOF'
curl -LsSf https://astral.sh/uv/install.sh | sh
source ${HOME}/.local/bin/env
SSH_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFBGOo3yytWfRyOhsWIg4wR/s6wbxWM+MIWLV0EnlkJK'
uvx --from dycw-installer[cli]@latest set-up-keys "${SSH_KEY}"
uvx --from dycw-installer[cli]@latest set-up-ssh
git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim
EOF
