# vim: filetype=zsh

xrdb "${XDG_CONFIG_HOME:-$HOME/.config}/Xresources" &

# Local bin to path
[ -d "$HOME/.local/bin" ] && \
  export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | sed 's/\/$//g' | paste -sd ':')"

# XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# XDG paths
export R_LIBS_USER="$XDG_DATA_HOME/R"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export ATOM_HOME="$XDG_DATA_HOME/atom"
export GOPATH="$XDG_DATA_HOME/go"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"
export LESSHISTFILE="-"

# Environment variables
export VISUAL="nvim"
export EDITOR="nvim"
export PAGER="less"
export TERMINAL="alacritty"
export SUDO_ASKPASS="$HOME/.local/bin/sudoaskpass-dmenu"

# Go bin to path
[ -d "$GOPATH/bin" ] && export PATH="$PATH:$GOPATH/bin"
