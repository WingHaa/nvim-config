local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
