ZVM_INIT_MODE=sourcing
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt globdots

setopt notify
unsetopt beep
bindkey -v

alias v=nvim
alias ls=exa
alias cat=bat

# git aliases
alias gst="git status"
alias gc="git commit -v"
alias gco="git checkout"
alias ga="git add"
alias gaa="git add --all"
alias gau="git add --update"
alias gp="git push"
alias gl="git pull"

export EDITOR=nvim
export FZF_DEFAULT_OPTS=" \
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

fpath=(~/.config/zsh/zsh-completions/src $fpath)
autoload -U compinit; compinit

source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.config/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.config/zsh/zsh-syntax-highlighting-theme.zsh

eval $(dircolors)
zstyle ':fzf-tab:*' query-string ''

zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' fzf-flags ${(z)FZF_DEFAULT_OPTS}
zstyle ':fzf-tab:*' default-color $'\033[30m'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


export PATH=$PATH:~/.local/bin/

export BAT_THEME="current-theme"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(fzf --zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
