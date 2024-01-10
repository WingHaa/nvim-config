local desc = require("util.keymap").desc
local map = vim.keymap

return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
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
	config = function(_, opts)
		require("harpoon").setup(opts)

		map.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>", desc("Harpoon add"))
		map.set("n", "<leader>hl", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", desc("Harpoon list"))
		map.set("n", "<M-k>", ":lua require('harpoon.ui').nav_next()<cr>", desc("Next harpoon"))
		map.set("n", "<M-j>", ":lua require('harpoon.ui').nav_prev()<cr>", desc("Previous harpoon"))
		map.set("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<cr>", desc("Harpoon 1"))
		map.set("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<cr>", desc("Harpoon 2"))
		map.set("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<cr>", desc("Harpoon 3"))
		map.set("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<cr>", desc("Harpoon 4"))
		map.set("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<cr>", desc("Harpoon 5"))
		map.set("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<cr>", desc("Harpoon 6"))
		map.set("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<cr>", desc("Harpoon 7"))
		map.set("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<cr>", desc("Harpoon 8"))
		map.set("n", "<leader>9", ":lua require('harpoon.ui').nav_file(9)<cr>", desc("Harpoon 9"))
	end,
}
