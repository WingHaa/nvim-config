local M = {}

M.setup = function(capabilities)
  require("lspconfig").jsonls.setup({
    capabilities = capabilities,
    filetypes = { "json", "jsonc" },
  })
end

return M
