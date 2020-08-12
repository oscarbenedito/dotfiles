# vim: filetype=zsh
# Load colors and set up prompt
autoload -U colors && colors
PS1="%B%{$fg[magenta]%}%n%{$fg[blue]%}@%{$fg[green]%}%M %{$fg[yellow]%}%~%b%{$fg[red]%}$%{$reset_color%} "

# Set up history and history file
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# antlr4
[ -z "$CLASSPATH" ] && export CLASSPATH=".:/home/oscar/Desktop/antlr/antlr-4.7.2-complete.jar" || export CLASSPATH=".:/home/oscar/Desktop/antlr/antlr-4.7.2-complete.jar:$CLASSPATH"
alias grun='java org.antlr.v4.gui.TestRig'

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
bindkey "^?" backward-delete-char

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
[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2> /dev/null
