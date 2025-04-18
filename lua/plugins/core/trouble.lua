local icons = require("lib.icons")

local M = {
    "folke/trouble.nvim",
}

M.keys = {
    {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
    },
    {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
    },
}

M.opts = {
    pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
    focus = false, -- Focus the window when opened
    follow = true, -- Follow the current item
    results = {
        win = {}, -- window options for the results window. Can be a split or a floating window.
        indent_guides = true, -- show indent guides
        multiline = true, -- render multi-line messages
        max_items = 200, -- limit number of items that can be displayed per section
        auto_open = false, -- auto open when there are items
        auto_close = false, -- auto close when there are no items
        auto_refresh = true, -- auto refresh when open
    },
    preview = {
        -- Window options for the preview window. Can be a split, floating window,
        -- or `main` to show the preview in the main editor window.
        win = { type = "main" },
        auto_open = true, -- automatically open preview when on an item
    },
    -- Throttle/Debounce settings. Should usually not be changed.
    ---@type table<string, number|{ms:number, debounce?:boolean}>
    throttle = {
        refresh = 20, -- fetches new data when needed
        update = 10, -- updates the window
        render = 10, -- renders the window
        follow = 10, -- follows the current item
        preview = { ms = 100, debounce = true }, -- shows the preview for the current item
    },
    -- Key mappings can be set to the name of a builtin action,
    -- or you can define your own custom action.
    keys = {
        ["?"] = "help",
        r = "refresh",
        R = "toggle_refresh",
        q = "close",
        o = "jump_close",
        ["<esc>"] = "cancel",
        ["<cr>"] = "jump",
        ["<2-leftmouse>"] = "jump",
        ["<c-s>"] = "jump_split",
        ["<c-v>"] = "jump_vsplit",
        -- go down to next item (accepts count)
        -- j = "next",
        ["}"] = "next",
        ["]]"] = "next",
        -- go up to prev item (accepts count)
        -- k = "prev",
        ["{"] = "prev",
        ["[["] = "prev",
        i = "inspect",
        p = "preview",
        P = "toggle_preview",
        zo = "fold_open",
        zO = "fold_open_recursive",
        zc = "fold_close",
        zC = "fold_close_recursive",
        za = "fold_toggle",
        zA = "fold_toggle_recursive",
        zm = "fold_more",
        zM = "fold_close_all",
        zr = "fold_reduce",
        zR = "fold_open_all",
        zx = "fold_update",
        zX = "fold_update_all",
        zn = "fold_disable",
        zN = "fold_enable",
        zi = "fold_toggle_enable",
    },
    modes = {
        symbols = {
            desc = "document symbols",
            mode = "lsp_document_symbols",
            focus = false,
            results = {
                win = { position = "right" },
            },
            filter = {
                -- remove Package since luals uses it for control flow structures
                ["not"] = { ft = "lua", kind = "Package" },
                any = {
                    -- all symbol kinds for help / markdown files
                    ft = { "help", "markdown" },
                    -- default set of symbol kinds
                    kind = {
                        "Class",
                        "Constructor",
                        "Enum",
                        "Field",
                        "Function",
                        "Interface",
                        "Method",
                        "Module",
                        "Namespace",
                        "Package",
                        "Property",
                        "Struct",
                        "Trait",
                    },
                },
            },
        },
    },
  -- stylua: ignore
  icons = {
    indent = {
      top           = "│ ",
      middle        = "├╴",
      last          = "└╴",
      -- last          = "-╴",
      -- last       = "╰╴", -- rounded
      fold_open     = " ",
      fold_closed   = " ",
      ws            = "  ",
    },
    folder_closed   = " ",
    folder_open     = " ",
    kinds = icons.kinds,
  },
}

return M
