# `dotfiles`

Dotfiles

## VM

```
Shared Clipboard = Bidirectional
VBoxManage controlvm "debian 13" poweroff
VBoxManage modifyvm "debian 13" --nic1 nat
VBoxManage modifyvm "debian 13" --natpf1 "ssh,tcp,127.0.0.1,2222,,22"
```
