local opts = {
  ensure_installed = {
    "lua_ls",
    "bashls",
    "phpactor",
    "tsserver",
    "clangd",
    "pyright",
    "vtsls",
    "jsonls",
    "sqlls",
  },
  automatic_installation = true,
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
