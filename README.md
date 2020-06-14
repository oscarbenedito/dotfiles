# Dotfiles

This directory hosts some of my dotfiles. It is currently a work in progress.

## Working with this repository

My solution is based on [this comment][hn-comment] (more info: [1][setup-1],
[2][setup-2]). A bare repository is initialized on a specified directory
(`$XDG_DATA_HOME/dotfiles` in my case) and then it is used as if it was in the
home directory (using the `--work-tree` option). I have aliased this git command
with options to `c` (see setup below). The `status.showUntrackedFiles no`
setting is used to avoid seeing all files in our home directory.

### Setup

To start your dotfiles from scratch:

```sh
git init --bare "$XDG_DATA_HOME/dotfiles"
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
c config --local status.showUntrackedFiles no
c config --local core.bare false
c config --local core.worktree "$HOME"
c push --set-upstream origin master
c branch --set-upstream-to=origin/master master
```

You should put the alias line on your `.zshrc` or `.bashrc`.

### Cloning

If you already have a repository and want to set up a new computer:

```sh
git clone --bare <git-repo-url> "$XDG_DATA_HOME/dotfiles"
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
c checkout
c config --local status.showUntrackedFiles no
c config --local core.bare false
c config --local core.worktree "$HOME"
c push --set-upstream origin master
c branch --set-upstream-to=origin/master master
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

## Notes

I have also created alises `c-clean` and `c-populate` to hide or show the files
`README.md` and `COPYING`. This functions will delete or override the files on
the home directory respectively.

On Debian, you might need to change ZSH's syntax highlightning plugin location
from `/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh` to
`/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`.

## Colors

I have the terminal emulator set up with the following colors (based on the
onedark vim theme):

| Color code | Color   | Color number |
| :--------: | :-----: | :----------: |
| 30         | black   | #282c34      |
| 31         | red     | #e06c75      |
| 32         | green   | #98c379      |
| 33         | yellow  | #e5c07b      |
| 34         | blue    | #61afef      |
| 35         | magenta | #c678dd      |
| 36         | cyan    | #56b6c2      |
| 37         | white   | #ffffff      |

## License

This repository is licensed under the CC0 1.0 Universal license and therefore is
part of the public domain. To the extent possible under law, Oscar Benedito, who
associated CC0 with this work, has waived all copyright and related or
neighboring rights to this work. You can find a copy of the CC0 license
[here][license].


[hn-comment]: <https://news.ycombinator.com/item?id=11071754>
[setup-1]: <https://www.atlassian.com/git/tutorials/dotfiles>
[setup-2]: <https://www.paritybit.ca/blog/how-i-manage-my-dotfiles>
[license]: <https://gitlab.com/oscarbenedito/dotfiles/blob/master/COPYING>
