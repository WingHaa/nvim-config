local M = {}

M.setup = function(capabilities)
  require("lspconfig").basedpyright.setup({
    capabilities = capabilities,
  })
end

return M
