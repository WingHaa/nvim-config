local map = vim.keymap
local M = {}

-- set keymaps on the active lsp server
M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	map.set("n", "fd", ":Lspsaga finder<CR>", opts)                        -- go to definition
	map.set("n", "gD", ":Lspsaga peek_definition<CR>", opts)               -- peak definition
	map.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)               -- go to definition
	map.set("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)           -- see available code actions
	map.set("n", "<leader>rn", ":Lspsaga rename<CR>", opts)                -- smart rename
	map.set("n", "<leader>gl", ":Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	map.set("n", "<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	map.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)          -- jump to prev diagnostic in buffer
	map.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)          -- jump to next diagnostic in buffer
	map.set("n", "K", ":Lspsaga hover_doc<CR>", opts)                      -- show documentation for what is under cursor

	if client.name == "pyright" then
		map.set("n", "<Leader>oi", ":PyrightOrganizeImports<CR>", opts)
	end

	if client.name == "tsserver" then
		map.set("n", "<Leader>oi",
			":lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<CR>",
			opts)
	end
end

M.diagnostic_signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = "" }

return M
