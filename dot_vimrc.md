# File `.vimrc`

## Latex-Suite
First of all we include the code required by `vim-latexsuite`. The following code is required and it makes vim invoke Latex-Suite when you open a tex file.
```vim file dot_vimrc
filetype plugin on
```

The following code is important as grep will sometimes skip displaying the file name if you search in a singe file. This will confuse Latex-Suite. Set your grep program to always generate a file-name.
```vim file dot_vimrc
set grepprg=grep\ -nH\ $*
```

The following code is optional and it enables automatic indentation as you type.
```vim file dot_vimrc
filetype indent on
```

The following code is optional. Starting with Vim 7, the filetype of empty `.tex` files defaults to 'plaintex' instead of 'tex', which results in vim-latex not being loaded. The following changes the default filetype back to 'tex':
```vim file dot_vimrc
let g:tex_flavor='latex'
let g:Tex_Folding=0
let g:Tex_AutoFolding=0
```

## Defaults
Configures indentation.
```vim file dot_vimrc
set expandtab
set shiftwidth=2
set tabstop=2
```

Configures syntax coloring.
```vim file dot_vimrc
syntax on
```

Show line number and other lines' relative number.
```vim file dot_vimrc
set number
set relativenumber
```

Setting the folding method to marker (you should use `{{{` and `}}}` to delimit areas that should fold).
```vim file dot_vimrc
set foldmethod=marker
```

Enable line wrapping by work.
```vim file dot_vimrc
set wrap
set linebreak
```

Set modeline to be able to change defaults in a per file basis.
```vim file dot_vimrc
set modeline
```

## Other useful commands
Shortcut to execute the make command.
```vim file dot_vimrc
:command Make :w | :!make
```

Sets the filetype for Latex documents.
```vim file dot_vimrc
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.cls set filetype=tex
autocmd BufRead,BufNewFile *.sty set filetype=tex
```

## License
This file is licensed under the CC0 1.0 Universal license and therefore is part of the public domain. To the extent possible under law, Oscar Benedito, who associated CC0 with this work, has waived all copyright and related or neighboring rights to this work. You can find a copy of the CC0 license [here](https://gitlab.com/oscarbenedito/dotfiles/blob/master/CC0-1.0).
