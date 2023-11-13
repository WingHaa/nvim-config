local add_desc = require("util.keymap").desc
return {
	"f-person/git-blame.nvim",
	cmd = "GitBlameToggle",
	init = function()
		require("gitblame").setup({
			enabled = false,
		})

		vim.keymap.set("n", "<leader>bt", ":GitBlameToggle<CR>", add_desc("Blame Toggle"))
	end,
}
