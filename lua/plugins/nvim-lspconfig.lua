local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local lsp_config = require("lspconfig.configs")

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- PHP
	require("lspconfig").phpactor.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		-- init_options = {
		-- 	["language_server_phpstan.enabled"] = true,
		-- 	["language_server_psalm.enabled"] = false,
		-- 	["php_code_sniffer.enabled"] = true,
		-- 	["language_server_php_cs_fixer.enabled"] = true,
		-- 	["language_server_phpstan.level"] = 8,
		-- },
		filetypes = { "php", "blade" },
	})

	-- Add custom blade lsp
	lsp_config.blade_ls = {
		default_config = {
			name = "blade_ls",
			cmd = { vim.fn.expand("$HOME/blade-lsp/builds/laravel-dev-tools"), "lsp" },
			filetypes = { "blade" },
			root_dir = function()
				return vim.loop.cwd()
			end,

			settings = {},
		},
	}
	-- Setup it
	lspconfig.blade_ls.setup({
		capabilities = capabilities,
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
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
		handlers = {
			["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
				if result.diagnostics == nil then
					return
				end

				-- ignore some tsserver diagnostics
				local idx = 1
				while idx <= #result.diagnostics do
					local entry = result.diagnostics[idx]

					local formatter = require("format-ts-errors")[entry.code]
					entry.message = formatter and formatter(entry.message) or entry.message

					-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
					if entry.code == 80001 then
						-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
						table.remove(result.diagnostics, idx)
					else
						idx = idx + 1
					end
				end

				vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
			end,
		},
	})

	-- typescript
	lspconfig.tailwindcss.setup({
		on_attach = on_attach,
		capabilities = capabilities,
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

	-- yaml
	lspconfig.yamlls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- toml
	lspconfig.taplo.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- docker file
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- docker compose
	lspconfig.docker_compose_language_service.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
	-- sql
	lspconfig.sqlls.setup({
		cmd = { "sql-language-server", "up", "--method", "stdio" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = function()
			return vim.loop.cwd()
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
	keys = {
		{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
		{ "<leader>ll", "<cmd>LspLog<cr>", desc = "Lsp Log" },
	},
}
