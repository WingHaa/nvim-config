return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        event = "BufReadPre",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
        keys = { { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "BufReadPre",
        opts = {
            ensure_installed = {
                "lua_ls",
                "bashls",
                "phpactor",
                "ts_ls",
                "clangd",
                "pyright",
                "vtsls",
                "jsonls",
                "sqlls",
                "gopls",
            },
            automatic_installation = true,
        },
        dependencies = "williamboman/mason.nvim",
    },
}
