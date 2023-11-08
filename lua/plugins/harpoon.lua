local opts = { noremap = true, silent = true }

return {
	'ThePrimeagen/harpoon',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {

		{ "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>",        "Harpoon add",      opts },
		{ "<leader>hl", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon list",     opts },
		{ "<leader>hn", ":lua require('harpoon.ui').nav_next()<cr>",          "Next harpoon",     opts },
		{ "<leader>hh", ":lua require('harpoon.ui').nav_prev()<cr>",          "Previous harpoon", opts },
		{ "<M-1>",      ":lua require('harpoon.ui').nav_file(1)<cr>",         "Harpoon 1",        opts },
		{ "<M-2>",      ":lua require('harpoon.ui').nav_file(2)<cr>",         "Harpoon 2",        opts },
		{ "<M-3>",      ":lua require('harpoon.ui').nav_file(3)<cr>",         "Harpoon 3",        opts },
		{ "<M-4>",      ":lua require('harpoon.ui').nav_file(4)<cr>",         "Harpoon 4",        opts },
		{ "<M-5>",      ":lua require('harpoon.ui').nav_file(5)<cr>",         "Harpoon 5",        opts },
		{ "<M-6>",      ":lua require('harpoon.ui').nav_file(6)<cr>",         "Harpoon 6",        opts },
		{ "<M-7>",      ":lua require('harpoon.ui').nav_file(7)<cr>",         "Harpoon 7",        opts },
		{ "<M-8>",      ":lua require('harpoon.ui').nav_file(8)<cr>",         "Harpoon 8",        opts },
		{ "<M-9>",      ":lua require('harpoon.ui').nav_file(9)<cr>",         "Harpoon 9",        opts },
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
