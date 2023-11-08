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
				if client.name ~= "copilot" then
					table.insert(buf_client_names, client.name)
				end

				if client.name == "copilot" then
					copilot_active = true
				end
			end

			-- Add linters (from nvim-lint)
			local lint_s, lint = pcall(require, "lint")
			if lint_s then
				for ft_k, ft_v in pairs(lint.linters_by_ft) do
					if type(ft_v) == "table" then
						for _, linter in ipairs(ft_v) do
							if buf_ft == ft_k then
								table.insert(buf_client_names, linter)
							end
						end
					elseif type(ft_v) == "string" then
						if buf_ft == ft_k then
							table.insert(buf_client_names, ft_v)
						end
					end
				end
			end

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
