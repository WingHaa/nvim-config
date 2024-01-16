local map = vim.keymap
local desc = require("util.keymap").desc
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

	telescope.load_extension("fzf")

	map.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", desc("Files by name"))
	map.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", desc("Grep files"))
	map.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", desc("Resume search"))
	map.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc("Recent files"))
	map.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", desc("Buffers"))
	map.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", desc("Keymaps"))
	map.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", desc("String at cursor"))
	map.set("n", "<leader>sb", "<cmd>Telescope git_branches<CR>", desc("Branches"))
	map.set("n", "<leader>sc", "<cmd>Telescope git_bcommits<CR>", desc("Branch commits"))
end

local use_telescope = false
return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = use_telescope,
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = config,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		enabled = use_telescope,
		build = "make",
		cmd = "Telescope",
	},
}
