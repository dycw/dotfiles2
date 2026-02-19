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
apt install -y age bat btm build-essential curl direnv du-dust eza fd-find \
    fzf git git-delta jq just restic ripgrep rsync sd shellcheck shfmt starship \
    sudo yq zoxide
apt autoremove -y
apt clean
usermod -aG sudo derek

bashrc_sh=/etc/profile.d/bashrc.sh
lines=$(cat <<'EOF'
eval "$(direnv hook bash)"
eval "$(fzf --bash)"
eval "$(starship init bash)"
eval "$(zoxide init --cmd j bash)"
EOF
)
touch ${bashrc_sh}
while IFS= read -r line; do
    grep -qxF "${line}" "${bashrc_sh}" || echo "${line}" >> "${bashrc_sh}"
done <<< "$lines"

curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
uvx --from dycw-installer[cli]@latest set-up-neovim

git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim
nvim --headless +Lazy! sync +qa




su - derek <<'EOF'
curl -LsSf https://astral.sh/uv/install.sh | sh
git clone --recurse-submodules https://github.com/queensberry-research/neovim.git ~/.config/nvim
echo uv
EOF
```

go inside with `ssh -p 2222 derek@127.0.0.1`
