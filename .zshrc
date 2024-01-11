HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -v
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

alias v=nvim
alias ls=exa
alias cat=bat
alias gst="git status"
alias gc="git commit -v"

export EDITOR=nvim

source ~/.config/zsh/zsh-syntax-highlighting-theme.zsh
source ~/.config/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.config/zsh/conda-zsh-completion/conda-zsh-completion.plugin.zsh

export PATH=$PATH:~/.local/bin/

export BAT_THEME="Catppuccin-frappe"

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
