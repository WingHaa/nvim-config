return {
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
		config = function()
			vim.g.tmux_navigator_no_mappings = 1
			vim.api.nvim_set_keymap("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { silent = true })
			-- vim.api.nvim_set_keymap("n","<C-\>", " :<C-U>TmuxNavigatePrevious<cr>", {silent=true})
		end,
	},
}
