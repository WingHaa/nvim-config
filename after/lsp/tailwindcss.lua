local lspconfig = require("lspconfig")

return {
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
}
