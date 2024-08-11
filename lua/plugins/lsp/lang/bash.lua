local M = {}

M.setup = function(capabilities)
  require("lspconfig").bashls.setup({
    capabilities = capabilities,
    filetypes = { "sh" },
  })
end

return M
