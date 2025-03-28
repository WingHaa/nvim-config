local desc = require("lib.keymap").desc

return {
    enabled = true,
    "yioneko/nvim-vtsls",
    config = function()
        local vtsls = require("vtsls")
        require("lspconfig.configs").vtsls = vtsls.lspconfig -- set default server config, optional but recommended
        -- If the lsp setup is taken over by other plugin, it is the same to call the counterpart setup function
        require("lspconfig").vtsls.setup({
            complete_function_calls = true,
            vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                    completion = {
                        enableServerSideFuzzyMatch = true,
                    },
                },
            },
            typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    parameterNames = { enabled = "literals" },
                    parameterTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = false },
                },
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
            callback = function()
                vim.keymap.set("n", "<Leader>oi", "<cmd>VtsExec organize_imports<CR>", desc("Organize Imports"))
                vim.keymap.set("n", "gD", "<cmd>VtsExec goto_source_definition<CR>", desc("Go to Source Definition"))
                vim.keymap.set("n", "<Leader>mi", "<cmd>VtsExec add_missing_imports<CR>", desc("Go to File References"))
                vim.keymap.set("n", "<Leader>rF", "<cmd>VtsExec rename_file<CR>", desc("Rename File"))
                vim.keymap.set("n", "<Leader>lr", "<cmd>VtsExec restart_tsserver<CR>", desc("Restart TS Server"))
                vim.keymap.set("n", "<Leader>lv", "<cmd>VtsExec select_ts_version<CR>", desc("Select TS Version"))
            end,
        })
    end,
}
