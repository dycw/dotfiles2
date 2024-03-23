#!/usr/bin/env zsh

# bat
if command -v bat &>/dev/null; then
	alias cat='bat'
fi

# bottom
if command -v btm &>/dev/null; then
	alias htop='btm'
fi

# cd
alias ~='cd "$HOME"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cddb='cd "$HOME"/Dropbox'
alias cddf='cd "$HOME"/dotfiles'
alias cddl='cd "$HOME"/Downloads'
alias cdw='cd "$HOME"/work'

# coverage
alias open-cov='open .coverage/html/index.html'

# direnv
if command -v direnv &>/dev/null; then
	alias dea='direnv allow'
fi

# eza
if command -v eza &>/dev/null; then
	__eza_base() { eza -F --group-directories-first --ignore-glob=node_modules "$@"; }
	__eza_short() { __eza_base -x "$@"; }
	function ls() { __eza_short --git-ignore "$@"; }
	function lsa() { __eza_short -a "$@"; }
	__eza_long() { __eza_base -ghl --git --time-style=long-iso "$@"; }
	__eza_long_default() { __eza_long -a --git-ignore "$@"; }
	function l() { __eza_long_default "$@"; }
	function ll() { __eza_long_default "$@"; }
	function la() { __eza_long -a "$@"; }

	if command -v watch &>/dev/null; then
		__watch_eza_base() {
			watch -d -n 0.1 --color -- \
				eza -aF --color=always --group-directories-first --ignore-glob=node_modules "$@"
		}
		__watch_eza_short() { __watch_eza_base -x "$@"; }
		function wls() { __watch_eza_short --git-ignore "$@"; }
		function wlsa() { __watch_eza_short -a "$@"; }
		__watch_eza_long() { __watch_eza_base -ghl --git --time-style=long-iso "$@"; }
		__watch_eza_long_default() { __watch_eza_long -a --git-ignore "$@"; }
		function wl() { __watch_eza_long_default "$@"; }
		function wll() { __watch_eza_long_default "$@"; }
		function wla() { __watch_eza_long -a "$@"; }
	fi
fi

# fd
if command -v fd &>/dev/null; then
	alias fdd='fd -Htd'
	alias fde='fd -Hte'
	alias fdf='fd -Htf'
	alias fds='fd -Hts'
fi

# fzf
__file="${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh"
if [ -f "$__file" ]; then
	source "$__file"
fi

# gh
if command -v gh &>/dev/null; then
	alias ghc='gh pr create'
	alias ghm='gh pr merge --auto'
	alias ghcm='gh pr create && gh pr merge --auto'
fi

# hypothesis
alias hypothesis-ci='export HYPOTHESIS_PROFILE=ci'
alias hypothesis-debug='export HYPOTHESIS_PROFILE=debug'
alias hypothesis-default='export HYPOTHESIS_PROFILE=default'
alias hypothesis-dev='export HYPOTHESIS_PROFILE=dev'

# input
set bell-style none
set editing-mode vi

# neovim
if command -v nvim &>/dev/null; then
	alias n='nvim'
	alias v='nvim'
	alias vim='nvim'
fi

# pip
alias pi='pip install'
alias pie='pip install --editable .'
alias piip='pip install ipython'
alias pijl='pip install jupyterlab jupyterlab-vim'
alias plo='pip list --outdated'
alias pui='pip uninstall'

# pre-commit
if command -v pre-commit &>/dev/null; then
	alias pca='pre-commit run -a'
	alias pcav='pre-commit run -av'
	alias pcau='pre-commit autoupdate'
	alias pci='pre-commit install'
fi

# ruff
if command -v ruff &>/dev/null; then
	alias rw='ruff check -w'
fi

# uv
if command -v uv &>/dev/null; then
	alias uvpi='uv pip install'
	alias uvpie='uv pip install --editable .'
	alias uvps='uv pip sync --strict requirements.txt'
fi

# zsh
alias zshrc='"$EDITOR" "$HOME"/dotfiles/zsh/main.zsh'

# zsh-vi-mode
if command -v brew &>/dev/null; then
	__file="$(brew --prefix)"/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
	if [ -f "$__file" ]; then
		# shellcheck source=/dev/null
		source "$__file"
	fi
fi

# ---- end ----

# conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
		# shellcheck source=/dev/null
		. "/opt/miniconda3/etc/profile.d/conda.sh"
	else
		export PATH="/opt/miniconda3/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<

# direnv
if command -v starship &>/dev/null; then
	eval "$(direnv hook zsh)"
fi

# starship
if command -v starship &>/dev/null; then
	eval "$(starship init zsh)"
fi

# zoxide
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh --cmd j --hook prompt)"
fi