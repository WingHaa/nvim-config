local M = {}

M.setup = function(capabilities)
    require("lspconfig").yamlls.setup({
        capabilities = capabilities,
    })
end

return M
