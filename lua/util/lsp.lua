local map = vim.keymap
local M = {}

-- set keymaps on the active lsp server
M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	local opts = { noremap = true, silent = true, buffer = bufnr }

	map.set("n", "<Leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	map.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	map.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	map.set("n", "gd", ":Telescope lsp_definitions<CR>", opts)
	map.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	map.set("n", "gi", ":Telescope lsp_implementations<CR>", opts)
	map.set("n", "go", ":Telescope lsp_references<CR>", opts)
	map.set("n", "<Leader>lr", ":LspRestart<CR>", opts)
	map.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	map.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

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
