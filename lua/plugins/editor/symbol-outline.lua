return {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  keys = { { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Outline Symbols" } },
  config = function()
    require("symbols-outline").setup()
  end,
}
