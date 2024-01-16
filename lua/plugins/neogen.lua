local add_desc = require("util.keymap").desc
vim.keymap.set("n", "<leader>nf", "<cmd>Neogen func<CR>", add_desc("Generate Docs"))

return {
	"danymat/neogen",
	cmd = "Neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("neogen").setup({ snippet_engine = "luasnip" })
	end,
	-- Follow only stable versions
	version = "*",
}
