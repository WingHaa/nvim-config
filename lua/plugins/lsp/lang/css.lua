local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")

  lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      "html",
      "typescriptreact",
      "javascriptreact",
      "css",
      "sass",
      "scss",
      "less",
      "svelte",
      "vue",
    },
  })

  lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return M
