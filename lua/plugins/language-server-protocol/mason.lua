local needed = {
    "basedpyright",
    "bash-language-server",
    "black",
    "blade-formatter",
    "clang-format",
    "clangd",
    "emmet-ls",
    "eslint_d",
    "gofumpt",
    "goimports",
    "golines",
    "gomodifytags",
    "google-java-format",
    "gopls",
    "gotests",
    "impl",
    "intelephense",
    "isort",
    "jdtls",
    "json-lsp",
    "lua-language-server",
    "php-cs-fixer",
    "phpactor",
    "phpcs",
    "prettier",
    "prettierd",
    "shfmt",
    "spring-boot-tools",
    "sql-formatter",
    "sqlls",
    "stylua",
    "typescript-language-server",
    "vtsls",
}

return {
    "mason-org/mason.nvim",
    cmd = "Mason",
    event = "BufReadPre",
    opts_extend = { "ensure_installed" },
    opts = {
        registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
        },
        ensure_installed = needed,
    },
    config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        mr:on("package:install:success", function()
            vim.defer_fn(function()
                -- trigger FileType event to possibly load this newly installed LSP server
                require("lazy.core.handler.event").trigger({
                    event = "FileType",
                    buf = vim.api.nvim_get_current_buf(),
                })
            end, 100)
        end)

        mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end)
    end,
    keys = { { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" } },
}
