local M = {}

M.setup = function(capabilities)
  local lspconfig = require("lspconfig")

  lspconfig.tailwindcss.setup({
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
  })
end

return M
