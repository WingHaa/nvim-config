return {
	"f-person/git-blame.nvim",
	cmd = "GitBlameToggle",
	init = function()
		require("gitblame").setup({
			enabled = false,
		})
	end,
	keys = {
		{ "<leader>bt", ":GitBlameToggle<CR>", "Blame Toggle" },
	},
}
