local desc = require("util.keymap").desc

vim.keymap.set("n", "<leader>dt", "<cmd>DBUIToggle<cr>", desc("Toggle Database UI"))

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
  {
    "napisani/nvim-dadbod-bg",
    build = "./install.sh",
    -- (optional) the default port is 4546
    -- (optional) the log file will be created in the system's temp directory
    config = function()
      vim.cmd([[
        let g:nvim_dadbod_bg_port = '4546'
        let g:nvim_dadbod_bg_log_file = '/tmp/nvim-dadbod-bg.log'
      ]])
    end,
  },
}
