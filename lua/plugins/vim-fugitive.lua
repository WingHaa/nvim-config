return {
	"tpope/vim-fugitive",
	event = "BufRead",
	keys = {
		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff" },
		{ "<leader>gs", "<cmd>G<cr>",          desc = "Git Status" },
		{ "<leader>gl", "<cmd>G log<cr>",      desc = "Git Log" },
	},
}
