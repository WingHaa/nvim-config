return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { silent = true } },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { silent = true } },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { silent = true } },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { silent = true } },
		-- { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", { silent = true } },
	},
}
