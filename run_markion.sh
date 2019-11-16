#!/bin/bash
for f in $(find $HOME/.local/share/chezmoi -name '*.md'); do
	python3.6 $HOME/.local/share/chezmoi/markion.py -D $f
done
