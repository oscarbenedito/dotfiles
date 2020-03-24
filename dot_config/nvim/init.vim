call plug#begin()
Plug 'junegunn/goyo.vim'      " minimalist design, nice for writing text
Plug 'vim-latex/vim-latex'
call plug#end()

" commands for latex-suite
filetype plugin on            " invokes latex-suite
set grepprg=grep\ -nH\ $*
filetype indent on            " automatic indentation
let g:tex_flavor='latex'
let g:Tex_Folding=0
let g:Tex_AutoFolding=0

autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.cls set filetype=tex
autocmd BufRead,BufNewFile *.sty set filetype=tex

" nerd tree shortcut
map <C-n> :NERDTreeToggle<CR>

" copying to clipboard
set clipboard=unnamedplus

" indentation
set expandtab
set shiftwidth=2
set tabstop=2

" line numbers
set number
set relativenumber

" line wrapping
set wrap
set linebreak

" splits configuraction
set splitbelow
set splitright

" switch C-j to C-o on latex-suite
imap <C-o> <Plug>IMAP_JumpForward
nmap <C-o> <Plug>IMAP_JumpForward

" set up vim-like commands to switch panels
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" key bindings
nnoremap U <C-r>

" set up colorscheme
colorscheme onedark
set t_ut=""                   " deactivates vim BCE option (messes up colors)

if (empty($TMUX))             " 24-bit true-color configuration
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" set up status line
" function! GitBranch()
"   let l:branchname = system("cd '".expand('%:p:h')."' && git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" let gitbranch={}
" autocmd BufRead,BufNewFile,FileReadPre * let gitbranch[expand('%:p')]=GitBranch()

set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=%{gitbranch[expand('%:p')]}
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
set laststatus=2              " activate status line

" other useful defaults
syntax on                     " syntax coloring
set foldmethod=marker         " using {{{ and }}} to delimit folding areas
set modeline
set colorcolumn=81            " color line 81 differently
set textwidth=80              " break lines longer than 80 characters
map <F2> <Esc>:w<CR>:!make<CR>
