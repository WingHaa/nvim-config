return {
	"tpope/vim-fugitive",
	event = "BufRead",
	keys = {
		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff" },
		{ "<leader>gs", "<cmd>G<cr>",          desc = "Git Status" },
		{ "<leader>gl", "<cmd>G log<cr>",      desc = "Git Log" },
		{ "<leader>gc", "<cmd>G commit<cr>",   desc = "Git Commit" },
		{ "<leader>gP", "<cmd>G push<cr>",     desc = "Git Push" },
		{ "<leader>gp", "<cmd>G pull<cr>",     desc = "Git Pull" },
		{ ":g",         ":G" },
	},
}
