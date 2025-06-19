local add_desc = require("lib.keymap").desc

local M = {
    "lewis6991/gitsigns.nvim",
}

M.opts = {
    current_line_blame_opts = {
        delay = 200,
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
