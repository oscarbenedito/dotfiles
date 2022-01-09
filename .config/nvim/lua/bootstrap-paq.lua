local function paq_install()
    local paq = require("plugins")
    vim.cmd "autocmd User PaqDoneInstall quit"
    paq.install()
end

return { run = paq_install }
