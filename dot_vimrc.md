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

Set a line in column 81 and cut lines after column 80.
```vim file dot_vimrc
set colorcolumn=81
set tw=80
```

Set the colorscheme.
```vim file dot_vimrc
colorscheme onedark
```

Deactivate vim's Background Color Erase (BCE) option
```vim file dot_vimrc
set t_ut=""
```

## Color scheme configuration
Use 24-bit (true-color) mode in Vim/Neovim when outside tmux. If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information).

```vim file dot_vimrc
if (empty($TMUX))
```

For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >

```vim file dot_vimrc
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
```

For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >. Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >.

```vim file dot_vimrc
  if (has("termguicolors"))
    set termguicolors
  endif
endif
```

## Status line

First of all, a function to get the git branch we are editing (if we are).
```vim file dot_vimrc
function! GitBranch()
  let l:branchname = system("cd ".expand('%:p:h')." && git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
```

We define `gitbranch` to the value of such function every time a file is opened.
```vim file dot_vimrc
let gitbranch={}
autocmd BufRead,BufNewFile,FileReadPre * let gitbranch[expand('%:p')]=GitBranch()
```

And then we define our status line, note that text between `#` are defining the color.
```vim file dot_vimrc
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{gitbranch[expand('%:p')]}
set statusline+=%#PmenuSbar#
set statusline+=\ %F
set statusline+=%m\  
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\  
```

And we finally activate the status line.
```vim file dot_vimrc
set laststatus=2
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
