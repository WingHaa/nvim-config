local opt = {
	build = ":TSUpdate",
	event = "VeryLazy",
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"css",
			"lua",
			"xml",
			"markdown",
		},
	},
	ensure_installed = {
		"markdown",
		"json",
		"javascript",
		"typescript",
		"yaml",
		"html",
		"css",
		"bash",
		"lua",
		"dockerfile",
		"gitignore",
		"vue",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-s>",
			node_incremental = "<C-s>",
			scope_incremental = false,
			node_decremental = "<BS>",
		},
	},
}

local config = function(_, opts)
	require("nvim-treesitter.configs").setup(opts)

	require("nvim-treesitter.parsers").get_parser_configs().blade = {
		install_info = {
			url = "https://github.com/EmranMR/tree-sitter-blade",
			files = { "src/parser.c" },
			branch = "main",
		},
		filetype = "blade",
	}
	vim.filetype.add({
		pattern = {
			[".*%.blade%.php"] = "blade",
		},
	})

	vim.api.nvim_create_autocmd({ "BufReadPost" }, {
		callback = function()
			local buf = vim.api.nvim_get_current_buf()

			local lines = vim.api.nvim_buf_get_lines(buf, 0, 100, false)
			local long_line = false

			for _, line in ipairs(lines) do
				if #line > 300 then
					long_line = true
					break
				end
			end

			if long_line then
				vim.cmd("syntax clear")
			end
		end,
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	opts = opt,
	config = config,
}
