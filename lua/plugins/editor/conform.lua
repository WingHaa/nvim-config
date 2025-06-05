vim.api.nvim_create_user_command("FormatToggle", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.autoformat = not vim.b.autoformat
    else
        vim.g.autoformat = not vim.g.autoformat
    end
end, {
    desc = "Toggle autoformat on save",
    bang = false,
})

local opts = {
    format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
    },
    -- Map of filetype to formatters
    formatters_by_ft = {
        blade = { "blade-formatter" },
        c = { "clang-format" },
        css = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofumpt", "golines" },
        gotmpl = { "prettier", stop_after_first = true },
        java = { "google-java-format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        mysql = { "sql_formatter" },
        php = { "php_cs_fixer" },
        python = { "isort", "black", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Custom formatters and changes to built-in formatters
    formatters = {
        blade = { "blade-formatter" },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
    },
    format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if not (vim.g.autoformat or vim.b[bufnr].autoformat) then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
}

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    keys = {
    -- stylua: ignore start
    { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format" },
    { "<leader>uf", "<cmd>FormatToggle<cr>", desc = "Toggle Format on Save" },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = opts,
    config = function(_, opt)
        local conf = require("neoconf").get("conform", opt)
        require("conform").setup(conf)
    end,
}
