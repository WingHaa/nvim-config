local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").nginx_language_server.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return M
