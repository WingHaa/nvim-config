return {
	"adalessa/laravel.nvim",
	opts = {
		split = {
			relative = "editor",
			position = "right",
			size = "30%",
			enter = true,
		},
		bind_telescope = true,
		lsp_server = "phpactor",
		register_user_commands = true,
		route_info = {
			enable = true,
			position = "right",
		},
	},
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
	cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
	keys = {
		{ "<leader>pa", ":Laravel artisan<cr>", desc = "Artisan commands" },
		{ "<leader>pr", ":Laravel routes<cr>",  desc = "Routes" },
		{ "<leader>pf", ":Laravel related<cr>", desc = "Related files" },
		{
			"<leader>pt",
			function()
				require("laravel.tinker").send_to_tinker()
			end,
			mode = "v",
			desc = "Laravel Application Routes",
		},
	},
	event = { "VeryLazy" },
	config = function(_, opts)
		require("laravel").setup(opts)
		require("telescope").load_extension "laravel"
	end,
}
