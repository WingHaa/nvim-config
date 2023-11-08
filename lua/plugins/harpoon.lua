return {
	'ThePrimeagen/harpoon',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {

		{ "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>",        "Harpoon add" },
		{ "<leader>hl", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon list" },
		{ "<leader>hn", ":lua require('harpoon.ui').nav_next()<cr>",          "Next harpoon" },
		{ "<leader>hh", ":lua require('harpoon.ui').nav_prev()<cr>",          "Previous harpoon" },
		{ "<leader>h1", ":lua require('harpoon.ui').nav_file(1)<cr>",         "Harpoon 1" },
		{ "<leader>h2", ":lua require('harpoon.ui').nav_file(2)<cr>",         "Harpoon 2" },
		{ "<leader>h3", ":lua require('harpoon.ui').nav_file(3)<cr>",         "Harpoon 3" },
		{ "<leader>h4", ":lua require('harpoon.ui').nav_file(4)<cr>",         "Harpoon 4" },
		{ "<leader>h5", ":lua require('harpoon.ui').nav_file(5)<cr>",         "Harpoon 5" },
		{ "<leader>h6", ":lua require('harpoon.ui').nav_file(6)<cr>",         "Harpoon 6" },
		{ "<leader>h7", ":lua require('harpoon.ui').nav_file(7)<cr>",         "Harpoon 7" },
		{ "<leader>h8", ":lua require('harpoon.ui').nav_file(8)<cr>",         "Harpoon 8" },
		{ "<leader>h9", ":lua require('harpoon.ui').nav_file(9)<cr>",         "Harpoon 9" },
	},
	opts = {
		global_settings = {
			-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
			save_on_toggle = true,

			-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
			tmux_autoclose_windows = true,

			-- filetypes that you want to prevent from adding to the harpoon list menu.
			excluded_filetypes = { "harpoon" },

			-- set marks specific to each git branch inside git repository
			mark_branch = false,
		}
	}
}
