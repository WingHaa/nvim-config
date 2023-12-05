return {
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-repeat",
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		keys = { { "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "Toggle Error" } },
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
	},
	{
		"windwp/nvim-ts-autotag",
		event = "BufRead",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Outline Symbols" } },
		config = function()
			require("symbols-outline").setup()
		end,
	},
}
