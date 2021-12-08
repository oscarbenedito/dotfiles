# vim: filetype=zsh
# Load colors and set up prompt
autoload -U colors && colors
setopt PROMPT_SUBST
PS1='%B%{$fg[magenta]%}%n%{$fg[blue]%}@%{$fg[green]%}%M %{$fg[yellow]%}%~%b%{$fg[cyan]%}$(git-head-abbrev)%{$fg[red]%}$%{$reset_color%} '

# Set up history and history file
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.cache/zsh/history

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY

# Set up navigation menu when pressing tab multiple times
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump
#_comp_options+=(globdots)

# Auto complete case insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Set up vi style keys
bindkey -v
export KEYTIMEOUT=1

# Also set vi keys to navigate the menus when double pressing tab
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Process the alias file
[ -f "$XDG_CONFIG_HOME/zsh/aliases" ] && source "$XDG_CONFIG_HOME/zsh/aliases"

# Process fzf key bindings
[ -f "$XDG_CONFIG_HOME/zsh/key-bindings.zsh" ] && source "$XDG_CONFIG_HOME/zsh/key-bindings.zsh"

# Include the highlighting plug-in
[ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2> /dev/null
