local M = {}

M.setup = function(capabilities)
  require("lspconfig").nginx_language_server.setup({
    capabilities = capabilities,
  })
end

return M
