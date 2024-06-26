local map = vim.keymap
local M = {}
local desc = require("util.keymap").desc

-- set keymaps on the active lsp server
M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  map.set("n", "<Leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc("Current Line Diagnostic"))
  map.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc("Prev Diagnostic"))
  map.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc("Next Diagnostic"))
  -- map.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc("Code Actions"))
  -- map.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", desc("Go to Definition"))
  -- map.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", desc("Go to Implementation"))
  -- map.set("n", "go", "<cmd>Telescope lsp_references<CR>", desc("Go to References"))
  map.set({ "n", "v" }, "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", desc("Code Actions"))
  map.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", desc("Definitions"))
  map.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", desc("Implementations"))
  map.set("n", "go", "<cmd>FzfLua lsp_references<CR>", desc("References"))
  map.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", desc("Type definition"))

  map.set("n", "<Leader>lr", "<cmd>LspRestart<CR>", desc("Restart LSP Server"))
  map.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc("Hover Definition"))
  map.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc("Rename Symbol"))
  map.set("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc("Signature Help"))

  if client.name == "pyright" then
    map.set("n", "<Leader>oi", "<cmd>PyrightOrganizeImports<CR>", desc("Organize Imports"))
  end

  if client.name == "tsserver" then
    map.set(
      "n",
      "<Leader>oi",
      "<cmd>lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<CR>",
      desc("Organize Imports")
    )
  end
end

M.opts = {
  virtual_text = true,
  signs = {
    text = { ERROR = " ", WARN = " ", HINT = "󰌵", INFO = "" },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = false,
    header = "",
    prefix = "",
  },
}

return M
