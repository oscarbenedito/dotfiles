xrdb "${XDG_CONFIG_HOME:-$HOME/.config}/Xresources" &

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv" ] && \
  . "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv"
