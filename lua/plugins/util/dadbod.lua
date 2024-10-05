local desc = require("lib.keymap").desc

vim.keymap.set("n", "<leader>dt", "<cmd>DBUIToggle<cr>", desc("Toggle Database UI"))

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        vim.b.ignore_early_retirement = true
    end,
})

return {
    {
        "tpope/vim-dadbod",
        cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            -- vim.g.dbs = {
            -- 	{ ["name"] = "NFTF", ["url"] = "mysql://root:root@0.0.0.0:3306/db_name" },
            -- }
            vim.g.db_ui_winwidth = 50
        end,
    },
}
