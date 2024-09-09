local opts = {
  ensure_installed = {
    "lua_ls",
    "bashls",
    "phpactor",
    "ts_ls",
    "clangd",
    "pyright",
    "vtsls",
    "jsonls",
    "sqlls",
    "gopls",
  },
  automatic_installation = true,
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
