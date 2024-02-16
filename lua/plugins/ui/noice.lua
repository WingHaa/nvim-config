local M = {
  "folke/noice.nvim",
  enabled = false,
  event = "VimEnter",
}

M.dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }

M.opts = {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      enabled = false,
      silent = true, -- set to true to not show a message if hover is not available
      view = nil, -- when nil, use defaults from documentation
      opts = {}, -- merged with defaults from documentation
    },
    signature = {
      enabled = false,
      auto_open = {
        enabled = true,
        trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
        luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
        throttle = 50, -- Debounce lsp signature help request by 50ms
      },
      view = nil, -- when nil, use defaults from documentation
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  views = {
    mini = {
      backend = "mini",
      timeout = 1500,
      size = { height = "auto", width = "auto", max_height = 5 },
      border = { style = "none" },
      zindex = 30,
      win_options = {
        winbar = "",
        foldenable = false,
        winblend = 40,
        winhighlight = { Normal = "NoiceMini" },
      },
    },
  },
}

M.opts.routes = {
  -- redirect to popup when message is long
  { filter = { min_height = 8 }, view = "split" },

  -- write/deletion messages
  { filter = { event = "msg_show", find = "%d+B written$" }, view = "mini" },
  { filter = { event = "msg_show", find = "%d+L, %d+B$" }, view = "mini" },
  { filter = { event = "msg_show", find = "%-%-No lines in buffer%-%-" }, view = "mini" },

  -- redo/undo messages
  { filter = { event = "msg_show", find = "%d+ changes?; %a+ #%d+" }, view = "mini" },
  { filter = { event = "msg_show", find = "1 more line" }, view = "mini" },
  { filter = { event = "msg_show", find = "1 line less" }, view = "mini" },
  { filter = { event = "msg_show", find = "%d+ more lines" }, view = "mini" },
  { filter = { event = "msg_show", find = "%d+ fewer lines" }, view = "mini" },
  { filter = { event = "msg_show", find = "^Already at %a+ change$" }, view = "mini" },

  -- unneeded info on search patterns
  -- { filter = { event = "msg_show", find = "^[/?]." }, skip = true },
  { filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },

  -- Word added to spellfile via `zg`
  { filter = { event = "msg_show", find = "^Word .*%.add$" }, view = "mini" },

  -- Diagnostics
  {
    filter = { event = "msg_show", find = "No more valid diagnostics to move to" },
    view = "mini",
  },

  -- :make
  { filter = { event = "msg_show", find = "^:!make" }, skip = true },
  { filter = { event = "msg_show", find = "^%(%d+ of %d+%):" }, skip = true },

  -----------------------------------------------------------------------------
  { -- nvim-early-retirement
    filter = {
      event = "notify",
      cond = function(msg)
        return msg.opts and msg.opts.title == "Auto-Closing Buffer"
      end,
    },
    view = "mini",
  },

  -- nvim-treesitter
  { filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" }, view = "mini" },
  { filter = { event = "notify", find = "All parsers are up%-to%-date" }, view = "mini" },

  -- LSP
  { filter = { event = "notify", find = "Restarting…" }, view = "mini" },

  -- Lazy
  { filter = { event = "notify", find = "Config Change Detected. Reloading..." }, view = "mini" },

  -- Mason
  { filter = { event = "notify", find = "%[mason%-tool%-installer%]" }, view = "mini" },
  {
    filter = {
      event = "notify",
      cond = function(msg)
        return msg.opts and msg.opts.title and msg.opts.title:find("mason.*.nvim")
      end,
    },
    view = "mini",
  },
}

M.config = function(_, opts)
  require("noice").setup(opts)
end

M.keys = {
  { "<leader>nh", "<cmd>NoiceHistory<cr>", desc = "Messages" },
  { "<leader>nd", "<cmd>NoiceDismiss<cr>", desc = "Noice Dismiss" },
  { "<leader>nc", "<cmd>NoiceDisable<cr>", desc = "Noice Close" },
  { "<leader>ne", "<cmd>NoiceEnable<cr>", desc = "Noice Enable" },
}

return M
