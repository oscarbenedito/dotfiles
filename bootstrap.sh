#!/bin/sh

if [ "$#" = "1" ] && [ "$1" = "--small" ]; then
    smallinstall="1"
elif [ "$#" != "0" ]; then
    echo "usage: bootstrap.sh [--small]"
    echo
    echo "    --small: copy only configuration for zsh, git, nvim and tmux (for servers or"
    echo "             root user)"
    exit 1
fi

repodest="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles/repo.git"
backupdest="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles/old-files"
tempdir="$(mktemp -d)"
mkdir -p "$(dirname $repodest)"

gitdotfiles() { git --git-dir="$repodest" --work-tree="$HOME" "$@"; }

git clone --separate-git-dir="$repodest" "https://git.oscarbenedito.com/dotfiles" "$tempdir" || exit 1
gitdotfiles config --local status.showUntrackedFiles no
gitdotfiles config --local core.worktree "$HOME"

cd "$tempdir"   # make sure we are not in another Git repository
for file in $(gitdotfiles ls-files); do
    if [ -f "$HOME/$file" ]; then
        mkdir -p "$(dirname "$backupdest/$file")"
        mv -f "$HOME/$file" "$backupdest/$file"
    fi
    mkdir -p "$(dirname "$HOME/$file")"
    mv -f "$tempdir/$file" "$HOME/$file"
done

mkdir -p "$HOME/.cache/zsh"

if [ "$smallinstall" = "1" ]; then
    for file in $(gitdotfiles ls-files | sed '/^\.config\/\(zsh\|git\/config\|nvim\|tmux\)\|^\.zshenv/d'); do
        rm -f "$HOME/$file"
        gitdotfiles update-index --skip-worktree "$HOME/$file"
        rmdir -p "$(dirname "$HOME/$file")" 2>/dev/null
    done
fi

rm -f "$HOME/README.md" "$HOME/COPYING" "$HOME/bootstrap.sh"
gitdotfiles update-index --skip-worktree "$HOME/README.md" "$HOME/COPYING" "$HOME/bootstrap.sh"

cd "$HOME"
rm -rf "$tempdir"

if [ -d "$backupdest" ]; then
    echo
    echo "Some files from the repository were already created in this machine, they have"
    echo "been moved to $backupdest."
fi

echo
echo "Installation finished."
