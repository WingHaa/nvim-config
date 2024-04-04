local M = {
  "kevinhwang91/nvim-bqf",
  event = { "BufRead", "BufNew" },
}

local D = {
  "junegunn/fzf",
  build = function()
    vim.fn["fzf#install"]()
  end,
}

M.opts = {
  auto_enable = true,
  preview = {
    show_title = false,
    show_scroll_bar = false,
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
  },
  func_map = {
    filter = "<C-n>",
    filterr = "<C-N>",
    fzffilter = "<C-f>",
  },
  filter = {
    fzf = {
      action_for = {
        ["ctrl-s"] = "split",
        ["ctrl-v"] = "vsplit",
        ["ctrl-q"] = "signtoggle",
        ["ctrl-c"] = "closeall",
      },
      extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
    },
  },
}

return { M, D }
