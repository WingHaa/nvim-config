vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract Function", noremap = true, nowait = true })
vim.keymap.set(
	"x",
	"<leader>rf",
	":Refactor extract_to_file ",
	{ desc = "Extract Function to file", noremap = true, nowait = true }
)
vim.keymap.set(
	"x",
	"<leader>rv",
	":Refactor extract_var ",
	{ desc = "Extract Variable", noremap = true, nowait = true }
)
vim.keymap.set(
	{ "n", "x" },
	"<leader>ri",
	":Refactor inline_var",
	{ desc = "Inline Variable", noremap = true, nowait = true }
)
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline Function", noremap = true, nowait = true })
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block ", { desc = "Extract block", noremap = true, nowait = true })
vim.keymap.set(
	"n",
	"<leader>rf",
	":Refactor extract_block_to_file",
	{ desc = "Extract block to file", noremap = true, nowait = true }
)

return {
	"ThePrimeagen/refactoring.nvim",
	cmd = "Refactor",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup({
			prompt_func_return_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
			show_success_message = true, -- shows a message with information about the refactor on success
			-- i.e. [Refactor] Inlined 3 variable occurrences
		})
	end,
}
