local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")

  -- dockerfile
  lspconfig.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- docker compose
  lspconfig.docker_compose_language_service.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return M
