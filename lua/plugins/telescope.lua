local map = vim.keymap
local key_opts = { noremap = true, silent = true }

local config = function()
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-k>"] = "move_selection_previous",
					["<C-j>"] = "move_selection_next",
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			live_grep = {},
			buffers = {},
		},
	})
end

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			map.set("n", "<leader>ff", ":Telescope find_files<CR>", key_opts),
			map.set("n", "<leader>fg", ":Telescope live_grep<CR>", key_opts),
			map.set("n", "<leader>fr", ":Telescope resume<CR>", key_opts),
			map.set("n", "<leader>fo", ":Telescope oldfiles<CR>", key_opts),
			map.set("n", "<leader>fb", ":Telescope buffers<CR>", key_opts),
			map.set("n", "<leader>fk", ":Telescope keymaps<CR>", key_opts),
			map.set("n", "<leader>fh", ":Telescope help_tags<CR>", key_opts),
			map.set("n", "<leader>fc", ":Telescope git_bcommits<CR>", key_opts),
			map.set("n", "<leader>fw", ":Telescope grep_string<CR>", key_opts),
		},
		config = config,
	},
}
