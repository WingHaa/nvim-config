return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require("leap")
    leap.opts = {
      max_phase_one_targets = nil,
      highlight_unlabeled_phase_one_targets = false,
      max_highlighted_traversal_targets = 10,
      case_sensitive = false,
      equivalence_classes = { " \t\r\n" },
      substitute_chars = {},
      safe_labels = "fnut/SFNLHMUGTZ?",
      labels = "fnjklhodweimbuyvrgtaqpcx/",
      special_keys = {
        next_target = "<enter>",
        prev_target = "<tab>",
        next_group = "<space>",
        prev_group = "<tab>",
        multi_accept = "<enter>",
        multi_revert = "<backspace>",
      },
    }

    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward-to)")
  end,
  keys = { "s", "S" },
}
