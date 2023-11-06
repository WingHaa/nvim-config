local function addPad(header)
	for _ = 1, 10 do
		table.insert(header, 1, [[]])
	end
	for _ = 1, 2 do
		table.insert(header, [[]])
	end
	return header
end

return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	opts = function()
		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = addPad(require('util.headers').neovim_banner),
				-- stylua: ignore
				center = {
					{ action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
					{ action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
					{ action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
					{ action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
					{ action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
					{ action = "qa", desc = " Quit", icon = " ", key = "q" },
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
	config = function()
		vim.api.nvim_set_hl(0, "DashboardHeader", { link = "@text.literal" })
		vim.api.nvim_set_hl(0, "DashboardKey", { link = "@label" })
		vim.api.nvim_set_hl(0, "DashboardIcon", { link = "@attribute" })
		vim.api.nvim_set_hl(0, "DashboardFooter", { link = "@text.reference" })
		vim.api.nvim_set_hl(0, "DashboardDesc", { link = "@attribute" })
	end
}
