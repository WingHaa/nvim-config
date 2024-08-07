return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  config = function()
    require("which-key").add({
      { "<leader>b", group = "Buffer/Blame" },
      { "<leader>c", group = "Code Action/Format" },
      { "<leader>d", group = "Diff/Database" },
      { "<leader>f", group = "Fuzzy Finder" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>l", group = "LSP/List char" },
      { "<leader>m", group = "Marks" },
      { "<leader>n", group = "Neodoc" },
      { "<leader>r", group = "Refactoring" },
      { "<leader>s", group = "Search LSP" },
      { "<leader>t", group = "Transparent" },
    })
  end,
}
