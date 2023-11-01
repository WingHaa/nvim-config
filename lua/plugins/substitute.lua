return {
	{
		"gbprod/substitute.nvim",
		config = function()
			local sub = require("substitute")
			sub.setup({})
			vim.keymap.set("n", "gr", sub.operator, { noremap = true })
			vim.keymap.set("n", "grr", sub.line, { noremap = true })
			vim.keymap.set("n", "gR", sub.eol, { noremap = true })
			vim.keymap.set("x", "gr", sub.visual, { noremap = true })
		end,
	},
}
