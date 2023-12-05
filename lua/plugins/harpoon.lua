local addDesc = require("util.keymap").desc

return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {

		{ "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>", addDesc("Harpoon add") },
		{ "<leader>hl", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", addDesc("Harpoon list") },
		{ "<leader>hn", ":lua require('harpoon.ui').nav_next()<cr>", addDesc("Next harpoon") },
		{ "<leader>hh", ":lua require('harpoon.ui').nav_prev()<cr>", addDesc("Previous harpoon") },
		{ "<leader>1", ":lua require('harpoon.ui').nav_file(1)<cr>", addDesc("Harpoon 1") },
		{ "<leader>2", ":lua require('harpoon.ui').nav_file(2)<cr>", addDesc("Harpoon 2") },
		{ "<leader>3", ":lua require('harpoon.ui').nav_file(3)<cr>", addDesc("Harpoon 3") },
		{ "<leader>4", ":lua require('harpoon.ui').nav_file(4)<cr>", addDesc("Harpoon 4") },
		{ "<leader>5", ":lua require('harpoon.ui').nav_file(5)<cr>", addDesc("Harpoon 5") },
		{ "<leader>6", ":lua require('harpoon.ui').nav_file(6)<cr>", addDesc("Harpoon 6") },
		{ "<leader>7", ":lua require('harpoon.ui').nav_file(7)<cr>", addDesc("Harpoon 7") },
		{ "<leader>8", ":lua require('harpoon.ui').nav_file(8)<cr>", addDesc("Harpoon 8") },
		{ "<leader>9", ":lua require('harpoon.ui').nav_file(9)<cr>", addDesc("Harpoon 9") },
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
		},
	},
}
