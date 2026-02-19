# `dotfiles`

Dotfiles

## VM

outside

```
VBoxManage controlvm "debian 13" poweroff
VBoxManage modifyvm "debian 13" --nic1 nat
VBoxManage modifyvm "debian 13" --natpf1 "ssh,tcp,127.0.0.1,2222,,22"
VBoxManage startvm "debian 13" --type headless
```

go inside with `ssh -p 2222 root@127.0.0.1`

```
tee /etc/apt/sources.list >/dev/null <<'EOF'
deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
EOF

rm -rf /var/lib/apt/lists/*
apt update
apt full-upgrade -y
apt autoremove -y
apt install -y btm build-essential curl git ripgrep rsync sd sudo
apt clean
usermod -aG sudo derek


curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
for cmd in direnv fzf starship zoxide; do
    uvx --from dycw-installer[cli]@latest set-up-${cmd} --etc
done

git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim
nvim --headless +Lazy! sync +qa




su - derek <<'EOF'
curl -LsSf https://astral.sh/uv/install.sh | sh
git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim
echo uv
EOF
```

go inside with `ssh -p 2222 derek@127.0.0.1`
