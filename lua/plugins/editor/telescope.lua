local desc = require("util.keymap").desc
local use_telescope = false
local M = {
	"nvim-telescope/telescope.nvim",
	enabled = use_telescope,
	branch = "0.1.x",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

local F = {
	"nvim-telescope/telescope-fzf-native.nvim",
	enabled = use_telescope,
	build = "make",
}

M.config = function()
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
end

M.keys = {
	{ "<leader>ff", "<cmd>Telescope find_files<CR>", "n", desc("Files by name") },
	{ "<leader>fg", "<cmd>Telescope live_grep<CR>", "n", desc("Grep files") },
	{ "<leader>fr", "<cmd>Telescope resume<CR>", "n", desc("Resume search") },
	{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", "n", desc("Recent files") },
	{ "<leader>fb", "<cmd>Telescope buffers<CR>", "n", desc("Buffers") },
	{ "<leader>fk", "<cmd>Telescope keymaps<CR>", "n", desc("Keymaps") },
	{ "<leader>fw", "<cmd>Telescope grep_string<CR>", "n", desc("String at cursor") },
	{ "<leader>sb", "<cmd>Telescope git_branches<CR>", "n", desc("Branches") },
	{ "<leader>sc", "<cmd>Telescope git_bcommits<CR>", "n", desc("Branch commits") },
}

return { M, F }
