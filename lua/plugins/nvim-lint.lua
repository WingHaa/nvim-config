return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = {
				"eslint_d",
			},
			typescript = {
				"eslint_d",
			},
			javascriptreact = {
				"eslint_d",
			},
			typescriptreact = {
				"eslint_d",
			},
			php = {
				"phpstan",
			},
		}

		vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave", "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
