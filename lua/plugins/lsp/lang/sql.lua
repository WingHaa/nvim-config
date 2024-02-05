local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")

  -- sql
  lspconfig.sqlls.setup({
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function()
      return vim.loop.cwd()
    end,
  })

  -- prisma
  lspconfig.prismals.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return M
