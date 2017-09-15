# Compinit
autoload -U compinit && compinit

# Case insensitive matching.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# zsh-completions
fpath=(path/to/zsh-completions/src $fpath)

# Code function
compdef '_files -W ~/Code -/' c
