return {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
        -- or "fzf-lua" or "snacks" or "default"
        picker = "fzf-lua",
        -- bare Octo command opens picker of commands
        enable_builtin = true,
    },
    keys = {
        {
            "<leader>gi",
            "<CMD>Octo issue list<CR>",
            desc = "List GitHub Issues",
        },
        {
            "<leader>gp",
            "<CMD>Octo pr list<CR>",
            desc = "List GitHub PullRequests",
        },
        {
            "<leader>gD",
            "<CMD>Octo discussion list<CR>",
            desc = "List GitHub Discussions",
        },
        {
            "<leader>gs",
            function()
                require("octo.utils").create_base_search_command({ include_current_repo = true })
            end,
            desc = "Search GitHub",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-telescope/telescope.nvim",
        "ibhagwan/fzf-lua",
        -- "folke/snacks.nvim",
        "nvim-tree/nvim-web-devicons",
    },
}
