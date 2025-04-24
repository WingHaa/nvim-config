local util = require("lspconfig.util")

local M = {}

M.setup = function(capabilities)
    local lspconfig = require("lspconfig")
    local lsp_config = require("lspconfig.configs")

    lspconfig.phpactor.setup({
        capabilities = capabilities,
        filetypes = { "php" },
        settings = {
            phpactor = {
                language_server_phpstan = { enabled = false },
                language_server_psalm = { enabled = false },
                inlayHints = {
                    enable = true,
                    parameterHints = false,
                    typeHints = true,
                },
            },
        },
    })

    -- Add custom blade lsp
    lsp_config.blade_ls = {
        default_config = {
            name = "blade_ls",
            cmd = { vim.fn.expand("$HOME/repo/tools/laravel-dev-tools/builds/laravel-dev-tools"), "lsp" },
            filetypes = { "blade" },
            root_dir = function(pattern)
                local cwd = vim.loop.cwd()
                local root = util.root_pattern("composer.json")(pattern)

                -- prefer cwd if root is a descendant
                return util.path.is_descendant(cwd, root) and cwd or root
            end,
            settings = {},
        },
    }
    -- Setup it
    lspconfig.blade_ls.setup({
        capabilities = capabilities,
    })
end

return M
