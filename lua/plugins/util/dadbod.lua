local desc = require("lib.keymap").desc

vim.keymap.set("n", "<leader>dt", "<cmd>DBUIToggle<cr>", desc("Toggle Database UI"))

return {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        {
            "kristijanhusak/vim-dadbod-ui",
            cmd = {
                "DBUI",
                "DBUIToggle",
                "DBUIAddConnection",
                "DBUIFindBuffer",
            },
            init = function()
                -- Your DBUI configuration
                vim.g.db_ui_use_nerd_fonts = 1
                -- vim.g.dbs = {
                -- 	{ ["name"] = "NFTF", ["url"] = "mysql://root:root@0.0.0.0:3306/db_name" },
                -- }
                vim.g.db_ui_winwidth = 50
            end,
        },
    },
}
