return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  opts = {
    indent = {
      char = "▏",
      tab_char = "▕",
    },
    scope = { enabled = false, show_start = false, show_end = false },
    exclude = {
      filetypes = require("util.exclude").filetype,
    },
  },
  main = "ibl",
}
