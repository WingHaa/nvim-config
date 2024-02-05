local add_desc = require("util.keymap").desc
return {
  "danymat/neogen",
  cmd = "Neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup({ snippet_engine = "luasnip" })
  end,
  keys = {
    { "<leader>nf", "<cmd>Neogen func<CR>", "n", add_desc("Generate Docs") },
  },
  -- Follow only stable versions
  version = "*",
}
