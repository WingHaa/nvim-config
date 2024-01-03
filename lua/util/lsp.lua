local map = vim.keymap
local M = {}
local desc = require("util.keymap").desc

-- set keymaps on the active lsp server
M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	local opts = { noremap = true, silent = true, buffer = bufnr }

	map.set("n", "<Leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc("Current Line Diagnostic"))
	map.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc("Prev Diagnostic"))
	map.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc("Next Diagnostic"))
	map.set("n", "gd", ":Telescope lsp_definitions<CR>", desc("Go to Definition"))
	map.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc("Code Actions"))
	map.set("n", "gi", ":Telescope lsp_implementations<CR>", desc("Go to Implementation"))
	map.set("n", "go", ":Telescope lsp_references<CR>", desc("Go to References"))
	map.set("n", "<Leader>lr", ":LspRestart<CR>", desc("Restart LSP Server"))
	map.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc("Hover Definition"))
	map.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc("Rename Symbol"))

	if client.name == "pyright" then
		map.set("n", "<Leader>oi", ":PyrightOrganizeImports<CR>", opts)
	end

	if client.name == "tsserver" then
		map.set(
			"n",
			"<Leader>oi",
			":lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<CR>",
			opts
		)
	end
end

M.diagnostic_signs = { Error = " ", Warn = " ", Hint = "󰌵", Info = "" }

return M
