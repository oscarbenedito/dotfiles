#!/bin/bash
for f in $(find $HOME/.local/share/chezmoi -name "*.md"); do
  if [ "$f" != "$HOME/.local/share/chezmoi/README.md" ]; then
    python3.6 $HOME/.local/share/chezmoi/markion.py -D $f
  fi
done
