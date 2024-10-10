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
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
}
