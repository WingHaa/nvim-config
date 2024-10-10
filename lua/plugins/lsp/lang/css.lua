local M = {}

M.setup = function(capabilities)
    local lspconfig = require("lspconfig")

    lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
            "blade",
            "css",
            "html",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
        },
    })

    lspconfig.emmet_ls.setup({
        capabilities = capabilities,
    })
end

return M
