local components = require("util.lualine.components")

local config = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = require("util.exclude").filetype,
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { components.vim },
			lualine_b = {
				{ "b:gitsigns_head", icon = "" },
				{ "diff", source = components.diffsource },
				"diagnostics",
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#ff9e64" },
				},
			},
			lualine_c = { "filename" },
			lualine_x = { components.lsp, "encoding", components.shiftwidth, "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPre",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = config,
}
