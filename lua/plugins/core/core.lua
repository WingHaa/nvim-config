return {
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                "luvit-meta/library", -- see below
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    "nvim-tree/nvim-web-devicons",
    "tpope/vim-repeat",
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
            vim.g.matchup_surround_enabled = 1

            require("nvim-treesitter.configs").setup({
                matchup = {
                    enable = true,
                    disable = {}, -- optional, list of language that will be disabled
                    disable_virtual_text = true,
                    include_match_words = true,
                },
            })
        end,
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
    },
}
