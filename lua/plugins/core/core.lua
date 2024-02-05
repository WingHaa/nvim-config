return {
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
  },
  {
    "folke/neodev.nvim",
    filetype = { "lua", "vim" },
  },
  "nvim-tree/nvim-web-devicons",
  "tpope/vim-repeat",
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    keys = { { "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "Toggle Error" } },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
  },
  {
    "LunarVim/bigfile.nvim",
  },
}
