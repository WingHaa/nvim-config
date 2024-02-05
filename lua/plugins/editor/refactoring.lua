local desc = require("util.keymap").desc

local M = {
  "ThePrimeagen/refactoring.nvim",
  cmd = "Refactor",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

M.config = function()
  require("refactoring").setup({
    prompt_func_return_type = {
      go = false,
      java = false,

      cpp = false,
      c = false,
      h = false,
      hpp = false,
      cxx = false,
    },
    prompt_func_param_type = {
      go = false,
      java = false,

      cpp = false,
      c = false,
      h = false,
      hpp = false,
      cxx = false,
    },
    printf_statements = {},
    print_var_statements = {},
    show_success_message = true, -- shows a message with information about the refactor on success
    -- i.e. [Refactor] Inlined 3 variable occurrences
  })
end

M.keys = {
  { "<leader>re", ":Refactor extract ", "x", desc("Extract Function", false) },
  { "<leader>rf", ":Refactor extract_to_file ", "x", desc("Extract Function to file", false) },
  { "<leader>rv", ":Refactor extract_var ", "x", desc("Extract Variable", false) },
  { "<leader>ri", ":Refactor inline_var", { "n", "x" }, desc("Inline Variable", false) },
  { "<leader>rI", ":Refactor inline_func", "n", desc("Inline Function", false) },
  { "<leader>rb", ":Refactor extract_block ", "n", desc("Extract block", false) },
  { "<leader>rf", ":Refactor extract_block_to_file", "n", desc("Extract block to file", false) },
}

return M
