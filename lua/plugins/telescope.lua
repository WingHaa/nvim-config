local map = vim.keymap

local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<Down>"] = "move_selection_next",
					["<Up>"] = "move_selection_previous",
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
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			map.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true }),
			map.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true }),
			map.set("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true }),
			map.set("n", "<leader>fk", ":Telescope keymaps<CR>", { noremap = true, silent = true }),
			map.set("n", "<leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true }),
		},
		config = config,
	},
}
