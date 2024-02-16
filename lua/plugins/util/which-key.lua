return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  config = function()
    require("which-key").register({
      b = { name = "Buffer/Blame" },
      c = { name = "Code Action/Format" },
      d = { name = "Diff/Database" },
      f = { name = "Fuzzy Finder" },
      g = { name = "Git" },
      h = { name = "Harpoon" },
      l = { name = "LSP/List char" },
      m = { name = "Marks" },
      r = { name = "Refactoring" },
      n = { name = "Neodoc" },
      s = { name = "Search LSP" },
      t = { name = "Transparent" },
    }, { prefix = "<leader>" })
  end,
}
