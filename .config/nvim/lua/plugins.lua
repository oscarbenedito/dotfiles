local ret = require("paq") {
    "sheerun/vim-polyglot",           -- languages syntax
    "tpope/vim-fugitive",             -- git wrapper
    "tpope/vim-surround",             -- add surrounding as objects
        "tpope/vim-repeat",           -- dependency of vim-surround
    "tpope/vim-commentary",           -- easily comment code
    "tpope/vim-eunuch",               -- helpers for UNIX shell commands
    "nvim-telescope/telescope.nvim",  -- fuzzy finding
        "nvim-lua/plenary.nvim",      -- dependency of telescope
    "vimwiki/vimwiki",                -- create a wiki with vim!
    { url="https://dev.sanctum.geek.nz/code/vim-redact-pass.git", shallow=false }, -- disable leaky options when editing passwords with pass
}


do -- vim-commentary
    vim.cmd [[
        augroup paq_vimcommentary
            autocmd!
            autocmd FileType apache,crontab setlocal commentstring=#\ %s
        augroup END
    ]]
end


do -- vim-eunuch
    vim.cmd "command! W SudoWrite"
end


do -- telescope
    vim.cmd "nnoremap <Leader>f <Cmd>Telescope find_files<CR>"
    vim.cmd "nnoremap <Leader>g <Cmd>Telescope git_files<CR>"
    vim.cmd "nnoremap <Leader>b <Cmd>Telescope buffers<CR>"
    vim.cmd "nnoremap <Leader>h <Cmd>Telescope help_tags<CR>"
    require("telescope-pickers")
end


do -- vimwiki
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_folding = "custom"

    -- first category is used for important meta files to be shown on root,
    -- last category is used for uncategorized files
    vim.g.vw_categories = { "Arrel", "Notes", "Temporal", "Receptes", "Blog", "Projectes", "Tecnologia", "Programari", "Altres", "Arxiu", "Sense categoria" }

    local vw_categories_str = ""
    for _, c in pairs(vim.g.vw_categories) do
        vw_categories_str = vw_categories_str .. " " .. string.gsub(c, " ", "\\ ")
    end
    vim.g.vimwiki_list = {{
        ["path"] = "~/Documents/wiki",
        ["path_html"] = "~/.cache/vimwiki/html",
        ["custom_wiki2html"] = "~/.local/share/vimwiki/wiki2html.py",
        ["syntax"] = "markdown",
        ["ext"] = ".md",
        ["template_path"] = "~/.local/share/vimwiki/",
        ["template_default"] = "template",
        ["template_ext"] = ".html",
        ["custom_wiki2html_args"] = "toc.md " .. vw_categories_str -- first argument is TOC file, then all the categories
    }}
end


return ret
