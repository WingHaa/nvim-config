return {
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-repeat",
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = { "<leader>u", "<cmd>UndotreeToggle<cr>", "Undotree" },
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
}
