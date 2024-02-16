local M = {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPre",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

local components = require("util.lualine.components")

M.opts = {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = require("util.exclude").filetype,
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { components.vim },
    lualine_b = {
      { "b:gitsigns_head", icon = "" },
      components.diff,
      "diagnostics",
    },
    lualine_c = {
      components.recording,
      "selectioncount",
    },
    lualine_x = {},
    lualine_y = {
      components.shiftwidth,
      "fileformat",
      "encoding",
      "progress",
    },
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
  tabline = {
    lualine_a = { "tabs" },
    lualine_b = { components.filetype, components.filename },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { components.lsp },
  },
}

return M
