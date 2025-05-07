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
        root_dir = lspconfig.util.root_pattern("tailwind.config.ts", "tailwind.config.js"),
    })

    lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = {
            "astro",
            "blade",
            "css",
            "eruby",
            "gotmpl",
            "html",
            "htmlangular",
            "htmldjango",
            "javascriptreact",
            "less",
            -- "php",
            "pug",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
        },
    })
end

return M
