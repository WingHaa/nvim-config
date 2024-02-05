local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "json", "jsonc" },
  })
end

return M
