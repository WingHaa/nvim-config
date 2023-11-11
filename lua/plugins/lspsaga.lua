return {
	"nvimdev/lspsaga.nvim",
	event = 'LspAttach',
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
				sign = false,
				virtual_text = true,
				debounce = 10,
				sign_priority = 40,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}
