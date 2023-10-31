return {
	"f-person/git-blame.nvim",
	init = function()
		vim.g.gitblame_enabled = 0
	end,
	keys = {
		{ "gt", ":GitBlameToggle<cr>", "Toggle Git Blame" },
	},
}
