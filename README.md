# Dotfiles
This directory hosts some of my dotfiles. It is currently a work in progress.

## Setup
I use [chezmoi](https://github.com/twpayne/chezmoi) to manage varying configs across different machines. I also use [Markion](https://gitlab.com/oscarbenedito/markion) to be able to write my programs as Markdown files and then extract the appropriate code. Thanks to chezmoi's script support I can run Markion and update the dotfiles, my problem is that currently scripts are run *after* the dotfiles are changed so two calls to `chezmoi apply` are needed as of right now.

## License
This program is licensed under the GPL v3. See [COPYING](https://gitlab.com/oscarbenedito/dotfiles/blob/master/COPYING) for the complete license.

Although the whole repository is released under GPL v3 (due to `markion.py` being licensed with it), many files are part of the public domain. See each individual. You can find a copy of the CC0 1.0 Universal license [here](https://gitlab.com/oscarbenedito/dotfiles/blob/master/CC0-1.0).
