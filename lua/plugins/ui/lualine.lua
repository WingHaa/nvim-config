local M = { "nvim-lualine/lualine.nvim" }

local components = require("lib.lualine.components")

M.opts = {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = require("lib.exclude").filetype,
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      components.vim,
    },
    lualine_b = {
      components.filename,
      components.diff,
      "diagnostics",
    },
    lualine_c = { "selectioncount" },
    lualine_x = { components.lsp },
    lualine_y = { components.shiftwidth },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  -- tabline = {
  --   lualine_a = { "tabs" },
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = { components.lsp },
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
}

return M
