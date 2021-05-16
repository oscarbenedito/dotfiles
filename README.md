# Dotfiles

This directory hosts some of my dotfiles.

## Palette

The colors used on most places are based on the vim onedark theme. They are the
following:

| Color code | Color   | Color number |
| :--------- | :------ | :----------- |
| 30         | black   | #282c34      |
| 31         | red     | #e06c75      |
| 32         | green   | #98c379      |
| 33         | yellow  | #e5c07b      |
| 34         | blue    | #61afef      |
| 35         | magenta | #c678dd      |
| 36         | cyan    | #56b6c2      |
| 37         | white   | #ffffff      |

## Working with this repository

My solution is based on [this comment][hn-comment] (more info: [1][setup-1],
[2][setup-2]). A bare repository is initialized on a specified directory
(`$XDG_DATA_HOME/dotfiles` in my case) and then it is used as if it was in the
home directory using the `--work-tree` option. I have aliased this git command
with options to `c` (see setup below). The `status.showUntrackedFiles no`
setting is used to avoid seeing all files in the home directory.

### Start from scratch

To start your dotfiles from scratch:

```sh
git init --bare "$XDG_DATA_HOME/dotfiles"
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
c config --local status.showUntrackedFiles no
c config --local core.bare false
c config --local core.worktree "$HOME"
c push --set-upstream origin master
```

You should put the alias line on your `.zshrc` or `.bashrc`.

### Replicate (method #1)

If you already have a repository and want to set up a new computer:

```sh
git clone --bare <git-repo-url> "$XDG_DATA_HOME/dotfiles"
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
c checkout
c config --local status.showUntrackedFiles no
c config --local core.bare false
c config --local core.worktree "$HOME"
c push --set-upstream origin master
```

You might need to add the following line to the file
`$XDG_DATA_HOME/dotfiles/config` under the origin master url for git to run
normally, I'm unsure why it doesn't do it by default, I'll investigate some
other time.

```toml
fetch = +refs/heads/*:refs/remotes/origin/*
```

If it gives an error because you already have dotfiles that would be overriden,
you can run the following to put them on a different folder and continue with
the process. You might need to create subfolder for the `mv` to work.

```sh
mkdir -p dotfiles-backup && \
  c checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} dotfiles-backup/{}
```

### Replicate (method #2)

If you don't care about deleting conflicting dotfiles on your computer, the
following method also works:

```sh
git clone --separate-git-dir="$XDG_DATA_HOME/dotfiles" <git-repo-url> dotfiles-tmp
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive my-dotfiles-tmp
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
c config --local status.showUntrackedFiles no
c config --local core.worktree "$HOME"
```

Run `c status` to make sure everywithing was copied as expected (symlinks will
not). Add the `--ignore-existing` to `rsync` to ignore already existing files,
so you don't override them.

### Notes

I have also created alises `c-clean` and `c-populate` to hide or show the files
`README.md` and `COPYING`. This functions will delete or override the files on
the home directory respectively.

On Debian, you might need to change ZSH's syntax highlightning plugin location
from `/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh` to
`/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`.

### Other programs you might/will need

Some of the programs you will need (and some you won't) are the following
(package names for Arch Linux, install with `pacman -S package1 package2 ...`:

```
# basic
xf86-video-intel zsh zsh-syntax-highlighting fzf neovim wget man cronie htop sshfs dash pacman-contrib
# xorg
xorg-server xorg-xinit
# utils
xorg-xrandr xorg-xbacklight alsa-utils alsa-lib alsa-plugins xwallpaper xcape xautolock pulseaudio xorg-xsetroot dunst xdotool udisks2 acpi scrot mlocate
# gnome
gnome gnome-extra
# fonts
noto-fonts ttf-font-awesome ttf-dejavu
# software
mpv thunderbird alacritty firefox signal-desktop pass transmission-cli syncthing youtube-dl jq
# other
texlive-most texlive-lang biber gtk2 gtk3 gvfs zathura mupdf zathura-pdf-mupdf pdftk
```

and don't forget to install `dwm`, `dmenu`, `slock` and `dwmblocks`:

```sh
mkdir -p ~/.local/src
git clone https://git.oscarbenedito.com/dwm ~/.local/src/dwm
git clone https://git.oscarbenedito.com/dmenu ~/.local/src/dmenu
git clone https://git.oscarbenedito.com/slock ~/.local/src/slock
git clone https://git.oscarbenedito.com/dwmblocks ~/.local/src/blocks
sudo make -C ~/.local/src/dwm install
sudo make -C ~/.local/src/dmenu install
sudo make -C ~/.local/src/slock install
sudo make -C ~/.local/src/blocks install
```

Also don't forget to put your wallpaper under
`~/.local/share/dwm/wallpaper.png` as well as enable PulseAudio:

```
systemctl --user enable pulseaudio.service
```

### Using the files on a server

If you just want to use a subset of the files (for example in case you want to
use them on a server), you can use `git update-index --skip-worktree file1
file2` to stop tracking files and then delete them. For example, to only use the
files under `.zshenv`, `.config/zsh`, `.config/git`, `.config/nvim` and
`.local/bin/git-head-abbrev`, you could run the following:

```
git --git-dir=/root/.local/share/dotfiles --work-tree=/root ls-files | \
  sed '/^\.config\/\(zsh\|git\|nvim\)\|^\.zshenv\|^\.local\/bin\/git-head-abbrev/d' | \
  xargs git --git-dir=/root/.local/share/dotfiles --work-tree=/root update-index --skip-worktree
git --git-dir=/root/.local/share/dotfiles --work-tree=/root ls-files | \
  sed '/^\.config\/\(zsh\|git\|nvim\)\|^\.zshenv\|^\.local\/bin\/git-head-abbrev/d' | \
  xargs rm -f
```

and add it to a `post-merge` hook. Alternatively, you can use multiple branches,
but I find that more complicated (you'll have to keep merging them).

## License

This repository is licensed under the CC0 1.0 Universal license and therefore is
part of the public domain. To the extent possible under law, Oscar Benedito, who
associated CC0 with this work, has waived all copyright and related or
neighboring rights to this work. You can find a copy of the CC0 license on the
`COPYING` file or [here][license].


[hn-comment]: <https://news.ycombinator.com/item?id=11071754>
[setup-1]: <https://www.atlassian.com/git/tutorials/dotfiles>
[setup-2]: <https://www.paritybit.ca/blog/how-i-manage-my-dotfiles>
[license]: <https://creativecommons.org/publicdomain/zero/1.0/>
