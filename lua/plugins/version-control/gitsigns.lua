local add_desc = require("lib.keymap").desc

local M = {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
}

M.opts = {
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true,
    },
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    on_attach = function()
        vim.keymap.set("n", "<leader>uw", "<cmd>Gitsigns toggle_word_diff<CR>", add_desc("Word Diff"))
        vim.keymap.set("n", "<leader>ub", "<cmd>Gitsigns toggle_current_line_blame<CR>", add_desc("Line Blame"))
        vim.keymap.set("n", "<leader>ud", "<cmd>Gitsigns toggle_deleted<CR>", add_desc("Toggle Deleted"))
        vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", add_desc("Stage Hunk"))
        vim.keymap.set({ "n", "v" }, "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", add_desc("Unstage hunk"))
        vim.keymap.set({ "n", "v" }, "<leader>gd", "<cmd>Gitsigns reset_hunk<CR>", add_desc("Drop hunk"))
    end,
}

return M
