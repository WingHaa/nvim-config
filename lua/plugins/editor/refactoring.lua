local desc = require("lib.keymap").noisy_desc
local M = {
    "ThePrimeagen/refactoring.nvim",
    cmd = "Refactor",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}

M.opts = {
    prompt_func_return_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
    },
    prompt_func_param_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
    },
    printf_statements = {},
    print_var_statements = {},
    show_success_message = true, -- shows a message with information about the refactor on success
    -- i.e. [Refactor] Inlined 3 variable occurrences
}

M.keys = {
    { "<leader>re", ":Refactor extract<CR>", mode = "v", desc("Extract Function") },
    { "<leader>rf", ":Refactor extract_to_file<CR>", mode = "v", desc("Extract Function to file") },
    { "<leader>rv", ":Refactor extract_var<CR>", mode = "v", desc("Extract Variable") },
    { "<leader>ri", ":Refactor inline_var<CR>", mode = { "n", "v" }, desc("Inline Variable") },
    { "<leader>rI", ":Refactor inline_func<CR>", mode = "n", desc("Inline Function") },
    { "<leader>rb", ":Refactor extract_block<CR>", mode = "n", desc("Extract block") },
    { "<leader>rB", ":Refactor extract_block_to_file<CR>", mode = "n", desc("Extract block to file") },
}

return M
