local add_desc = require("util.keymap").desc
return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("neogen").setup({ snippet_engine = "luasnip" })

		vim.keymap.set(
			"n",
			"<leader>nf",
			":lua require('neogen').generate({type='func'})<CR>",
			add_desc("Generate Docs")
		)
	end,
	-- Follow only stable versions
	version = "*",
}
