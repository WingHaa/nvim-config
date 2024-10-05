local M = {}

M.setup = function(capabilities)
    local lspconfig = require("lspconfig")

    -- dockerfile
    lspconfig.dockerls.setup({
        capabilities = capabilities,
    })

    -- docker compose
    lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
    })
end

return M
