return {
  "fraso-dev/nvim-listchars",
  cmd = {
    "ListcharsStatus",
    "ListcharsToggle",
    "ListcharsDisable",
    "ListcharsEnable",
    "ListcharsClearCache",
    "ListcharsLightenColors",
    "ListcharsDarkenColors",
  },
  config = function()
    require("nvim-listchars").setup({
      save_state = false,
      listchars = {
        eol = "↲",
        trail = "·",
        conceal = "┊",
        nbsp = "☠",
      },
      exclude_filetypes = require("util.exclude"),
      lighten_step = 10,
    })
  end,
  keys = {
    {
      "<leader>lo",
      "<cmd>ListcharsToggle<cr>",
      desc = "List chars toggle",
      silent = true,
      noremap = true,
      nowait = true,
    },
  },
}
