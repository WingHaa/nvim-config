local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- PHP
	require('lspconfig').intelephense.setup({
		commands = {
			IntelephenseIndex = {
				function()
					vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
				end,
			},
		},
		on_attach = function(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
		capabilities = capabilities
	})

	require('lspconfig').phpactor.setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			client.server_capabilities.completionProvider = false
			client.server_capabilities.hoverProvider = false
			client.server_capabilities.implementationProvider = false
			client.server_capabilities.referencesProvider = false
			client.server_capabilities.renameProvider = false
			client.server_capabilities.selectionRangeProvider = false
			client.server_capabilities.signatureHelpProvider = false
			client.server_capabilities.typeDefinitionProvider = false
			client.server_capabilities.workspaceSymbolProvider = false
			client.server_capabilities.definitionProvider = false
			client.server_capabilities.documentHighlightProvider = false
			client.server_capabilities.documentSymbolProvider = false
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
		init_options = {
			["language_server_phpstan.enabled"] = false,
			["language_server_psalm.enabled"] = false,
		},
		handlers = {
			['textDocument/publishDiagnostics'] = function() end
		}
	})

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- json
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- typescript
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript", "javascript", "typescriptreact", "javascriptreact"
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})

	-- bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

	-- solidity
	lspconfig.solidity.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "solidity" },
	})

	-- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
			"vue",
		},
	})

	-- docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	dependencies = {
		"williamboman/mason.nvim",
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
