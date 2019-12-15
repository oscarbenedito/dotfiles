#!/bin/bash
# Licensed under CC0 1.0 Universal. To the extent possible under law, Oscar
# Benedito, who associated CC0 with this work has waived all copyright and
# related or neighboring rights to this work.
for f in $(find $HOME/.local/share/chezmoi -name "*.md"); do
  if [ "$f" = "$HOME/.local/share/chezmoi/README.md" -o "${f%.*}" -nt "$f" ]; then
    continue
  fi
  python3 $HOME/.local/share/chezmoi/markion.py -D $f
done
