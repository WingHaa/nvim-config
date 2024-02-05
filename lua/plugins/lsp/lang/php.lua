local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")
  local lsp_config = require("lspconfig.configs")

  lspconfig.phpactor.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "php", "blade" },
    init_options = {
      ["language_server_phpstan.enabled"] = true,
      ["language_server_phpstan.level"] = "8",
    },
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
end

return M
