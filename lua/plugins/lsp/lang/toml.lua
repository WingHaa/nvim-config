local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").taplo.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return M
