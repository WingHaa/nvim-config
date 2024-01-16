local routes = {
	-- redirect to popup when message is long
	{ filter = { min_height = 8 }, view = "split" },

	-- write/deletion messages
	{ filter = { event = "msg_show", find = "%d+B written$" }, view = "mini" },
	{ filter = { event = "msg_show", find = "%d+L, %d+B$" }, view = "mini" },
	{ filter = { event = "msg_show", find = "%-%-No lines in buffer%-%-" }, view = "mini" },

	-- unneeded info on search patterns
	{ filter = { event = "msg_show", find = "^[/?]." }, skip = true },
	{ filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },

	-- Word added to spellfile via `zg`
	{ filter = { event = "msg_show", find = "^Word .*%.add$" }, view = "mini" },

	-- Diagnostics
	{
		filter = { event = "msg_show", find = "No more valid diagnostics to move to" },
		view = "mini",
	},

	-- :make
	{ filter = { event = "msg_show", find = "^:!make" }, skip = true },
	{ filter = { event = "msg_show", find = "^%(%d+ of %d+%):" }, skip = true },

	-----------------------------------------------------------------------------
	{ -- nvim-early-retirement
		filter = {
			event = "notify",
			cond = function(msg)
				return msg.opts and msg.opts.title == "Auto-Closing Buffer"
			end,
		},
		view = "mini",
	},

	-- nvim-treesitter
	{ filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" }, view = "mini" },
	{ filter = { event = "notify", find = "All parsers are up%-to%-date" }, view = "mini" },

	-- LSP
	{ filter = { event = "notify", find = "Restarting…" }, view = "mini" },

	-- Mason
	{ filter = { event = "notify", find = "%[mason%-tool%-installer%]" }, view = "mini" },
	{
		filter = {
			event = "notify",
			cond = function(msg)
				return msg.opts and msg.opts.title and msg.opts.title:find("mason.*.nvim")
			end,
		},
		view = "mini",
	},
}

return {
	"folke/noice.nvim",
	event = "VimEnter",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		-- "rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			-- routes = routes,
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			views = {
				mini = {
					backend = "mini",
					timeout = 1500,
					size = { height = "auto", width = "auto", max_height = 5 },
					border = { style = "none" },
					zindex = 30,
					win_options = {
						winbar = "",
						foldenable = false,
						winblend = 40,
						winhighlight = { Normal = "NoiceMini" },
					},
				},
			},
		})

		vim.api.nvim_set_hl(0, "NoiceMini", { link = "NormalFloat" })

		-- require("notify").setup({
		-- 	background_colour = "#000000",
		-- })
	end,
}
