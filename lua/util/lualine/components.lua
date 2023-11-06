return {
	lsp = {
		function()
			local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
			if #buf_clients == 0 then
				return "LSP Inactive"
			end

			local buf_ft = vim.bo.filetype
			local buf_client_names = {}
			local copilot_active = false

			-- add client
			for _, client in pairs(buf_clients) do
				if client.name ~= "null-ls" and client.name ~= "copilot" then
					table.insert(buf_client_names, client.name)
				end

				if client.name == "copilot" then
					copilot_active = true
				end
			end

			-- add formatter
			local formatters = require "lvim.lsp.null-ls.formatters"
			local supported_formatters = formatters.list_registered(buf_ft)
			vim.list_extend(buf_client_names, supported_formatters)

			-- add linter
			local linters = require "lvim.lsp.null-ls.linters"
			local supported_linters = linters.list_registered(buf_ft)
			vim.list_extend(buf_client_names, supported_linters)

			local unique_client_names = table.concat(buf_client_names, ", ")
			local language_servers = string.format("[%s]", unique_client_names)

			if copilot_active then
				language_servers = language_servers .. "%#SLCopilot#" .. " " .. "" .. "%*"
			end

			return language_servers
		end,
		color = { gui = "bold" },
	},
	shiftwidth = {
		function()
			local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
			return "󰌒" .. " " .. shiftwidth
		end,
		padding = 1,
	},
	encoding = {
		"o:encoding",
		fmt = string.upper,
		color = {},
	},
	filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
	scrollbar = {
		function()
			local current_line = vim.fn.line "."
			local total_lines = vim.fn.line "$"
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end,
		padding = { left = 0, right = 0 },
		color = "SLProgress",
		cond = nil,
	},
}
