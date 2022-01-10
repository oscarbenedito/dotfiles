# Dotfiles

This directory hosts some of my dotfiles.

## Palette

The colors used on most places are based on the vim onedark theme. They are the
following:

| Color   | Color number |
| :------ | :----------- |
| black   | #282c34      |
| red     | #e06c75      |
| green   | #98c379      |
| yellow  | #e5c07b      |
| blue    | #61afef      |
| magenta | #c678dd      |
| cyan    | #56b6c2      |
| white   | #ffffff      |
| bright black | #5c6370 |

## Working with this repository

My solution is based on [this comment][hn-comment] (more info: [here][setup-1]
and [here][setup-2]). A bare repository is initialized on a specified directory
(`$XDG_DATA_HOME/dotfiles` in my case) and then it is used as if it was in the
home directory using the `--work-tree` option. I have aliased this git command
with options to `c` (see setup below). The `status.showUntrackedFiles no`
setting is used to avoid seeing all files in the home directory.

To set up your computer with this repository, run the following:

```sh
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
git clone --bare "https://git.oscarbenedito.com/dotfiles" "$XDG_DATA_HOME/dotfiles"
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
c config --local status.showUntrackedFiles no
c config --local core.bare false
c config --local core.worktree "$HOME"
c checkout
```

If the last command gives an error because you already have dotfiles that would
be overriden, you can run the following to put them on a different folder and
continue with the process. You might need to create subfolder for the `mv` to
work.

```sh
mkdir -p dotfiles-backup && \
  c checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} dotfiles-backup/{}
```

### Notes

I have also created alises `c-clean` and `c-populate` to hide or show the files
`README.md` and `COPYING`. This functions will delete or override the files on
the home directory respectively.

On Debian, you might need to change ZSH's syntax highlightning plugin location
from `/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh` to
`/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`.

### Other notes for myself...

Some of the programs you will need on a new installation are the following
(package names for Arch Linux, install with `pacman -S package1 package2 ...`):

```
# basic
xf86-video-intel zsh zsh-syntax-highlighting fzf neovim wget man cronie htop sshfs dash pacman-contrib xclip inetutils
# xorg
xorg-server xorg-xinit
# utils
xorg-xrandr xorg-xbacklight alsa-utils alsa-lib alsa-plugins xwallpaper xcape xautolock pulseaudio xorg-xsetroot dunst xdotool udisks2 acpi scrot mlocate rsync feh exfat-utils
# gnome
gnome gnome-extra
# fonts
noto-fonts ttf-font-awesome ttf-dejavu
# software
mpv thunderbird alacritty firefox signal-desktop pass transmission-cli syncthing yt-dlp jq restic
# other
texlive-most texlive-lang biber gtk2 gtk3 gvfs zathura mupdf zathura-pdf-mupdf pdftk
```

and don't forget to install `dwm`, `dmenu`, `slock` and `dwmblocks` (by now
hopefully you have your SSH keys set up with the Git server):

```sh
mkdir -p ~/.local/src
git clone git@git.oscarbenedito.com:dwm ~/.local/src/dwm
git clone git@git.oscarbenedito.com:dmenu ~/.local/src/dmenu
git clone git@git.oscarbenedito.com:slock ~/.local/src/slock
git clone git@git.oscarbenedito.com:dwmblocks ~/.local/src/blocks
sudo make -C ~/.local/src/dwm install
sudo make -C ~/.local/src/dmenu install
sudo make -C ~/.local/src/slock install
sudo make -C ~/.local/src/blocks install
```

Enable PulseAudio and syncthing, download neovim plugins:

```
systemctl --user enable pulseaudio.service
sudo systemctl enable "syncthing@$USER.service"
nvim --headless -u NONE -c 'lua require("bootstrap-paq").run()'
```

Finally, don't forget to put your wallpaper under
`~/.local/share/dwm/wallpaper.png`.

### Using a subset of the files

If you just want to use a subset of the files without wanting to create a new
branch (for example in case you want to use them on a server), you can use `git
update-index --skip-worktree file1 file2` to stop tracking files and then delete
them. For example, to only use the files under `.zshenv`, `.config/zsh`,
`.config/git`, `.config/nvim` and `.config/tmux`, you could run the following:

```
git --git-dir=/root/.local/share/dotfiles --work-tree=/root ls-files | \
  sed '/^\.config\/\(zsh\|git\|nvim\|tmux\)\|^\.zshenv/d' | \
  xargs git --git-dir=/root/.local/share/dotfiles --work-tree=/root update-index --skip-worktree
git --git-dir=/root/.local/share/dotfiles --work-tree=/root ls-files | \
  sed '/^\.config\/\(zsh\|git\|nvim\|tmux\)\|^\.zshenv/d' | \
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
