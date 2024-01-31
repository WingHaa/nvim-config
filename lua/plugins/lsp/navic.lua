return {
	"SmiteshP/nvim-navic",
	requires = "neovim/nvim-lspconfig",
	opts = {
		icons = {
			File = "󰈙 ",
			Module = " ",
			Namespace = "󰌗 ",
			Package = " ",
			Class = "󰌗 ",
			Method = "󰆧 ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = "󰕘",
			Interface = "󰕘",
			Function = "󰊕 ",
			Variable = "󰆧 ",
			Constant = "󰏿 ",
			String = "󰀬 ",
			Number = "󰎠 ",
			Boolean = "◩ ",
			Array = "󰅪 ",
			Object = "󰅩 ",
			Key = "󰌋 ",
			Null = "󰟢 ",
			EnumMember = " ",
			Struct = "󰌗 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰊄 ",
		},
		lsp = {
			auto_attach = true,
			preference = nil,
		},
		highlight = true,
		separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		safe_output = true,
		lazy_update_context = true,
		click = false,
		format_text = function(text)
			return text
		end,
	},
	config = function(_, opts)
		require("nvim-navic").setup(opts)
		vim.o.winbar = " %{%v:lua.require('nvim-navic').get_location()%}"
	end,
}
