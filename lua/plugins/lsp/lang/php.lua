local M = {}

M.setup = function(capabilities)
  local lspconfig = require("lspconfig")
  local lsp_config = require("lspconfig.configs")

  lspconfig.intelephense.setup({
    on_attach = function(client)
      client.server_capabilities.workspaceSymbolProvider = false
      client.server_capabilities.diagnosticProvider = false
    end,
    settings = { php = { completion = { callSnippet = "Replace" } } },
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php", "blade" },
  })

  lspconfig.phpactor.setup({
    on_attach = function(client)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.documentSymbolProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.completionProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.implementationProvider = true
      client.server_capabilities.typeDefinitionProvider = false
    end,
    capabilities = capabilities,
    filetypes = { "php" },
    init_options = {
      ["language_server_phpstan.enabled"] = true,
      ["language_server_phpstan.level"] = "8",
      ["phpunit.enabled"] = true,
      ["language_server_reference_reference_finder.reference_timeout"] = 600,
    },
    settings = {
      phpactor = {
        language_server_phpstan = { enabled = false },
        language_server_psalm = { enabled = false },
        inlayHints = {
          enable = true,
          parameterHints = true,
          typeHints = true,
        },
      },
    },
  })

  -- Add custom blade lsp
  lsp_config.blade_ls = {
    default_config = {
      name = "blade_ls",
      cmd = { vim.fn.expand("$HOME/blade-lsp/builds/laravel-dev-tools"), "lsp" },
      filetypes = { "blade" },
      root_dir = lspconfig.util.root_pattern("composer.json"),
      settings = {},
    },
  }
  -- Setup it
  lspconfig.blade_ls.setup({
    capabilities = capabilities,
  })
end

return M
