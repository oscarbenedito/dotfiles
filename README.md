# Dotfiles

This directory hosts some of my dotfiles. It is currently a work in progress.

## Setup

My solution is based on [this comment][hn-comment] (more info: [1][setup-1],
[2][setup-2]).

### Other issues

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
