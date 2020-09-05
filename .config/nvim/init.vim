"         _
"  __   _(_)_ __ ___  _ __ ___
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__
"  (_)_/ |_|_| |_| |_|_|  \___|
"

" plugins {{{

call plug#begin()
Plug 'junegunn/goyo.vim'        " minimalist design, nice for writing text
Plug 'vim-latex/vim-latex', { 'for': 'tex' }
Plug 'sheerun/vim-polyglot'     " languages syntax
Plug 'tpope/vim-surround'       " surrounding objects
Plug 'tpope/vim-commentary'     " easily comment objects
Plug 'tpope/vim-repeat'         " make surround commands repeatable
Plug 'tpope/vim-fugitive'       " git wrapper
Plug 'vimwiki/vimwiki'
call plug#end()

" netrw
let g:netrw_liststyle=3         " tree structure
let g:netrw_banner=0            " get rid of banner
let g:netrw_winsize=20          " when on side, only use 20% of space
let g:netrw_browse_split=4      " open files in previous window
" adds 'number' and 'relativenumber', other options are the default ones
let g:netrw_bufsettings="nomodifiable nomodified number nobuflisted nowrap readonly relativenumber"

" latex-suite
filetype plugin on              " invokes latex-suite
set grepprg=grep\ -nH\ $*
filetype indent on              " automatic indentation
let g:tex_flavor='latex'
let g:Tex_Folding=0
let g:Tex_AutoFolding=0
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.cls set filetype=tex
autocmd BufRead,BufNewFile *.sty set filetype=tex
" change change latex-suite C-j shortcut on normal mode
nnoremap <Leader>n <Plug>IMAP_JumpForward

" vimwiki
let g:vimwiki_list=[{ 'path': '~/Documents/wiki', 'path_html': '~/Documents/wiki/build/html', 'custom_wiki2html': '~/Documents/wiki/build/build.py', 'syntax': 'markdown', 'ext': '.md' }]
let g:vimwiki_folding='expr'
let g:vimwiki_global_ext=0
autocmd FileType vimwiki set foldlevel=1
:nnoremap <Leader>t <Plug>VimwikiVSplitLink

" /plugins }}}

" change default behaviours {{{

let mapleader=","               " set ',' as leader
set hidden                      " hide buffers instead of closing them
set path+=**                    " find in subdirectories as well
set mouse=""                    " gets rid of mouse, should be by default

" indentation
set expandtab                   " insert spaces instead of tabs
set tabstop=4                   " number of spaces when tab is pressed
set shiftwidth=4                " number of spaces for indentation

" line numbers
set number                      " show line numbers
set relativenumber              " show numbers relative to current line

" line wrapping
set wrap                        " wrap lines
set linebreak                   " don't cut words when wrapping
set breakindent                 " keeps indentation on wrapped lines
set showbreak=↪↪                " adds characters in front of wrapped line

" new splits position
set splitbelow
set splitright

" other useful defaults
syntax on                       " syntax coloring
set foldmethod=marker           " using {{{ and }}} to delimit folding areas
set modeline                    " enable per-file settings with modeline
set colorcolumn=81              " color column 81 differently
set textwidth=80                " break lines longer than 80 characters, this is done to change behaviour of gq, see next line
set formatoptions-=t            " don't break lines when longer than textwidth
set nojoinspaces                " joining lines: no double space after period
set scrolloff=3                 " minimum #lines between cursor and edge when scrolling

" undo
set undofile                    " save undos after file closes
set undodir=$HOME/.config/nvim/undo     " where to save undo histories

" show blank characters when invisible
set list
set listchars=tab:>-,trail:·,extends:#,nbsp:.

" switch : and ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap ñ :
nnoremap Ñ :
vnoremap ñ :
nnoremap Ñ ;

" filetypes
autocmd BufRead,BufNewFile *.zone set filetype=bindzone

" filetype specific
autocmd FileType markdown,vimwiki,mail set formatoptions+=t  " break lines when longer than textwidth
autocmd FileType markdown,vimwiki set tabstop=2         " number of spaces when tab is pressed
autocmd FileType markdown,vimwiki set shiftwidth=2      " number of spaces for indentation
autocmd FileType mail set textwidth=72

" /change default behaviours }}}

" shortcuts {{{

" set up vim-like commands to switch panes
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" resize pane
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>

" undo
nnoremap U <C-r>

" search and replace all
nnoremap S :%s//g<Left><Left>

" edit/reload config file
nnoremap <silent> <Leader>v :e $MYVIMRC<CR>
nnoremap <silent> <Leader>r :so $MYVIMRC<CR>

" edit file
nnoremap <Leader>e :Lexplore<CR>

" clean search highlights
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" space to toggle fold
nnoremap <Space> za

" /shortcuts }}}

" colorscheme {{{

colorscheme onedark
set t_ut=""                     " deactivates vim BCE option (messes up colors)
set termguicolors

" /colorscheme }}}

" status line {{{

set statusline=
set statusline+=%#PmenuSbar#
set statusline+=%F
set statusline+=%m\  
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\  
set laststatus=2                " activate status line

" /status line }}}

" templates {{{

nnoremap <Leader>sh :-1read $XDG_CONFIG_HOME/nvim/templates/shebang.sh<CR>:w<CR>:e<CR>j
nnoremap <Leader>latexs :-1read $XDG_CONFIG_HOME/nvim/templates/summary.tex<CR>
nnoremap <Leader>latexg :-1read $XDG_CONFIG_HOME/nvim/templates/tex.gitignore<CR>
nnoremap <Leader>latexm :-1read $XDG_CONFIG_HOME/nvim/templates/tex.Makefile<CR>

" /templates }}}

" other {{{

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" /other }}}
