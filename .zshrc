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

source ~/.config/zsh/zsh-syntax-highlighting-theme.zsh
source ~/.config/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.config/zsh/conda-zsh-completion/conda-zsh-completion.plugin.zsh
source ~/.config/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

zstyle ':autocomplete:*' insert-unambiguous yes
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'

export PATH=$PATH:~/.local/bin/

export BAT_THEME="current-theme"

autoload -Uz compinit
compinit
source <(docker completion zsh)

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


export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
