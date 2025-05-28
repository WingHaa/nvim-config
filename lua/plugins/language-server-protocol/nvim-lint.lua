return {
    "mfussenegger/nvim-lint",
    ft = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
    },
    opts = {
        linters_by_ft = {
            javascript = {
                "eslint_d",
            },
            typescript = {
                "eslint_d",
            },
            javascriptreact = {
                "eslint_d",
            },
            typescriptreact = {
                "eslint_d",
            },
            php = {
                "phpcs",
            },
        },
        linters = {
            phpcs = {
                args = {
                    "-q",
                    "--standard=phpcs.xml",
                    "--report=json",
                    "-",
                },
            },
        },
    },
    config = function(_, opts)
        local lint = require("lint")
        require("neoconf.plugins").register({
            on_schema = function(schema)
                schema:import("lint", opts)
            end,
        })

        local settings = require("neoconf").get("lint", opts)
        if settings.linters_by_ft then
            lint.linters_by_ft = settings.linters_by_ft
        end

        if settings.linters then
            for name, config in pairs(settings.linters) do
                if lint.linters[name] then
                    for k, v in pairs(config) do
                        lint.linters[name][k] = v
                    end
                end
            end
        end

        vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave", "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
