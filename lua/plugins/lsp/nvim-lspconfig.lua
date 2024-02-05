local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs
local langs = {
  "bash",
  "css",
  "docker",
  "json",
  "lua",
  "php",
  "sql",
  "toml",
  "yaml",
}

local config = function()
  require("neoconf").setup({})

  for type, icon in pairs(diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  local M = vim.lsp.protocol.make_client_capabilities()

  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not ok then
    vim.notify("Could not load nvim-cmp")
    return
  end

  local capabilities = cmp_nvim_lsp.default_capabilities(M)

  for _, lang in pairs(langs) do
    require("plugins.lsp.lang." .. lang).setup(on_attach, capabilities)
  end
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },
  keys = {
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    { "<leader>ll", "<cmd>LspLog<cr>", desc = "Lsp Log" },
  },
}
