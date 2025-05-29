return {
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = function()
            require("neoconf").setup()
        end,
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
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {},
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    "tpope/vim-repeat",
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
            vim.g.matchup_surround_enabled = 1

            require("nvim-treesitter").setup({
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
        keys = { { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
    },
}
