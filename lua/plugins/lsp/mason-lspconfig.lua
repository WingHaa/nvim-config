local opts = {
  ensure_installed = {
    "lua_ls",
    "bashls",
    "phpactor",
    "tsserver",
    "pyright",
    "jsonls",
  },
  automatic_installation = true,
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
