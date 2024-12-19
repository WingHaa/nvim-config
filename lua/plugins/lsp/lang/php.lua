local util = require("lspconfig.util")

local M = {}

M.setup = function(capabilities)
    local lspconfig = require("lspconfig")
    local lsp_config = require("lspconfig.configs")

    lspconfig.intelephense.setup({
        on_attach = function(client)
            client.server_capabilities.workspaceSymbolProvider = false
            client.server_capabilities.diagnosticProvider = false
        end,
        settings = { php = { completion = { callSnippet = "Replace" } } },
        cmd = { "intelephense", "--stdio" },
        filetypes = { "php", "blade" },
        root_dir = function(pattern)
            local cwd = vim.loop.cwd()
            local root = util.root_pattern("composer.json")(pattern)

            -- prefer cwd if root is a descendant
            return util.path.is_descendant(cwd, root) and cwd or root
        end,
    })

    lspconfig.phpactor.setup({
        on_attach = function(client)
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.documentSymbolProvider = false
            client.server_capabilities.referencesProvider = false
            client.server_capabilities.completionProvider = false
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.definitionProvider = false
            client.server_capabilities.implementationProvider = true
            client.server_capabilities.typeDefinitionProvider = false
        end,
        capabilities = capabilities,
        filetypes = { "php" },
        settings = {
            phpactor = {
                language_server_phpstan = { enabled = false },
                language_server_psalm = { enabled = false },
                inlayHints = {
                    enable = true,
                    parameterHints = true,
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
