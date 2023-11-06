return {
	'ThePrimeagen/harpoon',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>",        "Harpoon add" },
		{ "<leader>hl", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon list" },
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
