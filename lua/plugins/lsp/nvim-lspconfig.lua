local langs = {
  "bash",
  "c",
  "css",
  "docker",
  "json",
  "lua",
  "nginx",
  "php",
  "sql",
  "toml",
  "yaml",
}

local M = {
  "neovim/nvim-lspconfig",
}

M.dependencies = {
  "williamboman/mason.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
}

M.keys = {
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  { "<leader>ll", "<cmd>LspLog<cr>", desc = "Lsp Log" },
}

function M.config()
  local utils = require("util.lsp")

  vim.diagnostic.config(utils.opts)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  local C = vim.lsp.protocol.make_client_capabilities()

  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not ok then
    vim.notify("Could not load nvim-cmp")
    return
  end

  local capabilities = cmp_nvim_lsp.default_capabilities(C)
  for _, lang in pairs(langs) do
    require("plugins.lsp.lang." .. lang).setup(utils.on_attach, capabilities)
  end
end

return M
