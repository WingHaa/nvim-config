local picker = require("lib.picker")
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = {
            enabled = true,
            indent = { char = "▏" },
            animate = { enabled = false },
            scope = { enabled = false },
            chunk = { enabled = false },
            -- filter for buffers to enable indent guides
            filter = function(buf)
                return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
            end,
        },
        input = { enabled = true },
        picker = picker.conf,
        notifier = { enabled = false },
        quickfile = { enabled = true },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
    keys = picker.keys,
}
