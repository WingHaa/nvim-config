local L = { "ggandor/leap.nvim", keys = { "s", "S" } }

local F = { "ggandor/flit.nvim" }

L.opts = {
  max_phase_one_targets = nil,
  highlight_unlabeled_phase_one_targets = false,
  max_highlighted_traversal_targets = 10,
  case_sensitive = false,
  equivalence_classes = { " \t\r\n" },
  substitute_chars = {},
  safe_labels = "fnut/SFNLHMUGTZ?",
  labels = "bcdefghijklmnopqrstuvwxyz",
  special_keys = {
    next_target = "<enter>",
    prev_target = "<tab>",
    next_group = "<space>",
    prev_group = "<tab>",
    multi_accept = "<enter>",
    multi_revert = "<backspace>",
  },
}

L.config = function(_, opts)
  require("leap").setup(opts)
  vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward-to)")
  vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward-to)")
  vim.keymap.set({ "n", "x", "o" }, "R", require("lib.ts-selector"))
end

F.opts = {
  keys = { f = "f", F = "F", t = "t", T = "T" },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "o",
  multiline = false,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {},
}

return { L, F }
