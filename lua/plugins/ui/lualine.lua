local components = require("util.lualine.components")

local config = function()
  require("lualine").setup({
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
        {
          "diff",
          symbols = { added = " ", modified = " ", removed = " " },
          source = components.diffsource,
        },
        "diagnostics",
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        components.shiftwidth,
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
      lualine_a = {},
      lualine_b = {
        {
          "filetype",
          colored = true, -- Displays filetype icon in color if set to true
          icon_only = true, -- Display only an icon for filetype
          icon = { align = "right" }, -- Display filetype icon on the right hand side
        },
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = true, -- Display new file status (new file means no write after created)
          path = 0, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          symbols = {
            modified = "", -- Text to show when the file is modified.
            readonly = "", -- Text to show when the file is non-modifiable or readonly.
            unnamed = " ", -- Text to show for unnamed buffers.
            newfile = "󰎔", -- Text to show for newly created file before first write
          },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { components.lsp },
      lualine_z = {},
    },
  })
end

return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPre",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = config,
}
