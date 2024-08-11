local M = {}

M.setup = function(capabilities)
  local lspconfig = require("lspconfig")

  -- sql
  lspconfig.sqlls.setup({
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    capabilities = capabilities,
    root_dir = function()
      return vim.loop.cwd()
    end,
  })

  -- prisma
  lspconfig.prismals.setup({
    capabilities = capabilities,
  })
end

return M
