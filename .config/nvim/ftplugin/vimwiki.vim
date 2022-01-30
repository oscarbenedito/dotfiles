nnoremap <buffer> <Leader>wha <Cmd>VimwikiAll2HTML<CR>

augroup ftplugin_vimwiki
    autocmd!
    autocmd BufWritePost <buffer> silent <Cmd>Vimwiki2HTML
augroup END
