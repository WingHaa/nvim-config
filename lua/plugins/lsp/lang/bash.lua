local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "sh" },
  })
end

return M
