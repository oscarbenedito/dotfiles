local function paq_install()
    vim.g.headless_bootstrap = true
    local paq = require("plugins")
    vim.cmd "autocmd User PaqDoneInstall quit"
    paq.install()
end

return { run = paq_install }
