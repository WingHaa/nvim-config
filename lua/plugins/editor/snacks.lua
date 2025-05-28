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
            indent = {
                char = "▏",
            },
            scope = {
                enabled = false,
            },
        },
        image = { enabled = true },
        input = { enabled = true },
        picker = require("lib.picker").conf,
        notifier = { enabled = false },
        quickfile = { enabled = true },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
    keys = require("lib.picker").keys,
}
