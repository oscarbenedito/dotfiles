vim.pack.add({
    "https://github.com/sheerun/vim-polyglot",           -- languages syntax
    "https://github.com/tpope/vim-fugitive",             -- git wrapper
    "https://github.com/tpope/vim-surround",             -- add surrounding as objects
        "https://github.com/tpope/vim-repeat",           -- dependency of vim-surround
    "https://github.com/tpope/vim-commentary",           -- easily comment code
    "https://github.com/tpope/vim-eunuch",               -- helpers for UNIX shell commands
    "https://github.com/nvim-telescope/telescope.nvim",  -- fuzzy finding
        "https://github.com/nvim-lua/plenary.nvim",      -- dependency of telescope
    "https://github.com/vimwiki/vimwiki",                -- create a wiki with vim!
}, { load = true })

-- don't run the package configs if we are doing the initial bootstrap
if vim.g.headless_bootstrap then
    return ret
end


vim.api.nvim_create_user_command('PackUpdate', function()
    vim.pack.update()
end, {})


do -- vim-commentary
    vim.cmd [[
        augroup plugin_vimcommentary
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
