local desc = require("lib.keymap").noisy_desc
local M = {
    "ThePrimeagen/refactoring.nvim",
    event = "CmdlineEnter",
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

vim.keymap.set("v", "<leader>re", ":Refactor extract ", desc("Extract Function"))
vim.keymap.set("v", "<leader>rf", ":Refactor extract_to_file ", desc("Extract Function to file"))
vim.keymap.set("v", "<leader>rv", ":Refactor extract_var ", desc("Extract Variable"))
vim.keymap.set({ "n", "v" }, "<leader>ri", ":Refactor inline_var", desc("Inline Variable"))
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", desc("Inline Function"))
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block ", desc("Extract block"))
vim.keymap.set("n", "<leader>rB", ":Refactor extract_block_to_file", desc("Extract block to file"))

return M
