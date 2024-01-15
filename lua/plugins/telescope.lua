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
			path_display = {
				"smart",
				"shorten",
			},
			file_ignore_patterns = { "node_modules" },
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			colorscheme = {
				enable_preview = true,
			},
			live_grep = {},
			buffers = {},
		},
	})

	map.set(
		"n",
		"<leader>ff",
		"<cmd>lua require('telescope.builtin').find_files({hidden=false})<CR>",
		{ desc = "Files by name", silent = true }
	)
	map.set(
		"n",
		"<leader>fg",
		"<cmd>lua require('telescope.builtin').live_grep()<CR>",
		{ desc = "Grep files", silent = true }
	)
	map.set(
		"n",
		"<leader>fr",
		"<cmd>lua require('telescope.builtin').resume()<CR>",
		{ desc = "Resume search", silent = true }
	)
	map.set(
		"n",
		"<leader>fo",
		"<cmd>lua require('telescope.builtin').oldfiles()<CR>",
		{ desc = "Recent files", silent = true }
	)
	map.set(
		"n",
		"<leader>fb",
		"<cmd>lua require('telescope.builtin').buffers()<CR>",
		{ desc = "Buffers", silent = true }
	)
	map.set(
		"n",
		"<leader>fk",
		"<cmd>lua require('telescope.builtin').keymaps()<CR>",
		{ desc = "Keymaps", silent = true }
	)
	map.set(
		"n",
		"<leader>fh",
		"<cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>",
		{ desc = "Hidden Files", silent = true }
	)
	map.set(
		"n",
		"<leader>fw",
		"<cmd>lua require('telescope.builtin').grep_string()<CR>",
		{ desc = "String at cursor", silent = true }
	)
	map.set(
		"n",
		"<leader>sb",
		"<cmd>lua require('telescope.builtin').git_branches()<CR>",
		{ desc = "Branches", silent = true }
	)
	map.set(
		"n",
		"<leader>sc",
		"<cmd>lua require('telescope.builtin').git_bcommits()<CR>",
		{ desc = "Branch commits", silent = true }
	)
end

return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = config,
	},
}
