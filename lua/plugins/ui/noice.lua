local M = {
    "folke/noice.nvim",
    event = "VimEnter",
    enabled = false,
}

M.dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }

local routes = {
    -- redirect to popup when message is long
    { filter = { min_height = 6 }, view = "mini" },

    -- write/deletion messages
    { filter = { event = "msg_show", find = "%d+B written$" }, view = "mini" },
    { filter = { event = "msg_show", find = "yanked" }, view = "mini" },
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
    { filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },

    { filter = { event = "notify", find = "completion request failed" }, skip = true },
    { filter = { event = "msg_show", find = "codeium.log" }, skip = true },

    -- Word added to spellfile via `zg`
    { filter = { event = "msg_show", find = "^Word .*%.add$" }, view = "mini" },

    -- Diagnostics
    {
        filter = { event = "msg_show", find = "No more valid diagnostics to move to" },
        view = "mini",
    },
    { filter = { find = "coding standard is not installed" }, view = "mini" },

    -- :make
    { filter = { event = "msg_show", find = "^:!make" }, skip = true },
    { filter = { event = "msg_show", find = "^%(%d+ of %d+%):" }, skip = true },

    -----------------------------------------------------------------------------
    {
        filter = {
            event = "lsp",
            kind = "progress",
            cond = function(message)
                local client = vim.tbl_get(message.opts, "progress", "client")
                return client == "lua_ls"
            end,
        },
        opts = { skip = true },
    },
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

M.opts = {
    cmdline = {
        --     view = "cmdline",
        format = {
            cmdline = {
                title = " Command ",
                -- icon = "",
            },
            -- search_down = {
            -- view = "cmdline",
            -- },
            -- search_up = {
            -- view = "cmdline",
            -- },
        },
    },
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        hover = {
            enabled = false,
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    views = {
        mini = {
            backend = "mini",
            timeout = 1000,
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
    routes = routes,
}

M.config = function(_, opts)
    require("noice").setup(opts)
end

M.keys = {
    { "<leader>nh", "<cmd>NoiceHistory<cr>", desc = "Messages" },
    { "<leader>nd", "<cmd>NoiceDisable<cr>", desc = "Noice Close" },
    { "<leader>ne", "<cmd>NoiceEnable<cr>", desc = "Noice Enable" },
}

return {
    M,
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.25)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.25)
            end,
            render = "wrapped-compact",
        },
    },
}
