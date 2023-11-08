local map = vim.keymap

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
			map.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Files by name" }),
			map.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Grep files" }),
			map.set("n", "<leader>fr", ":Telescope resume<CR>", { desc = "Resume search" }),
			map.set("n", "<leader>fo", ":Telescope oldfiles<CR>", { desc = "Recent files" }),
			map.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" }),
			map.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" }),
			map.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Helps" }),
			map.set("n", "<leader>fw", ":Telescope grep_string<CR>", { desc = "String at cursor" }),
			map.set("n", "<leader>sb", ":Telescope git_branches<CR>", { desc = "Branches" }),
			map.set("n", "<leader>sc", ":Telescope git_bcommits<CR>", { desc = "Branch commits" }),
		},
		config = config,
	},
}
