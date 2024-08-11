local M = {}

M.setup = function(capabilities)
  require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    settings = { -- custom settings for lua
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })
end

return M
