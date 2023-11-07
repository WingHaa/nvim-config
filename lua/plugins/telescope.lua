local map = vim.keymap
local key_opts = { noremap = true, silent = true }

local config = function()
	local telescope = require("telescope")
	local project_actions = require("telescope._extensions.project.actions")

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
		extensions = {
			project = {
				base_dirs = { '~/dev/src', { path = '~/src', max_depth = 2 } },
				hidden_files = false, -- default: false
				theme = "dropdown",
				order_by = "asc",
				search_by = "title",
				sync_with_nvim_tree = true, -- default false
				-- default for on_project_selected = find project files
				on_project_selected = function(prompt_bufnr)
					-- Do anything you want in here. For example:
					project_actions.change_working_directory(prompt_bufnr, false)
				end
			}
		}
	})
	telescope.load_extension('project')
end

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-project.nvim" },
		keys = {
			map.set("n", "<leader>ff", ":Telescope find_files<CR>", key_opts),
			map.set("n", "<leader>fg", ":Telescope live_grep<CR>", key_opts),
			map.set("n", "<leader>fr", ":Telescope resume<CR>", key_opts),
			map.set("n", "<leader>fo", ":Telescope oldfiles<CR>", key_opts),
			map.set("n", "<leader>fb", ":Telescope buffers<CR>", key_opts),
			map.set("n", "<leader>fk", ":Telescope keymaps<CR>", key_opts),
			map.set("n", "<leader>fh", ":Telescope help_tags<CR>", key_opts),
			map.set("n", "<leader>fp", ":Telescope project<CR>", key_opts),
			map.set("n", "<leader>fc", ":Telescope git_bcommits<CR>", key_opts),
		},
		config = config,
	},
}
