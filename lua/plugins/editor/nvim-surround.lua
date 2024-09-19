return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {
    keymaps = {
      normal = "ys",
      delete = "ds",
      visual = "S",
      visual_line = "gS",
      change = "cs",
      change_line = "cS",
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
    },
  },
  aliases = {
    ["a"] = ">",
    ["b"] = ")",
    ["B"] = "}",
    ["r"] = "]",
    ["q"] = { '"', "'", "`" },
    ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
  },
  highlight = {
    duration = 500,
  },
  move_cursor = "begin",
}
