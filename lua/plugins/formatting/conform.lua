vim.api.nvim_create_user_command("FormatToggle", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.autoformat = not vim.b.autoformat
  else
    vim.g.autoformat = not vim.g.autoformat
  end
end, {
  desc = "Toggle autoformat on save",
  bang = false,
})

local opts = {
  format = {
    timeout_ms = 3000,
    async = false, -- not recommended to change
    quiet = false, -- not recommended to change
  },
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    python = { "isort", "black" },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    scss = { { "prettierd", "prettier" } },
    php = { { "php_cs_fixer", "prettierd" } },
    sql = { "sql_formatter" },
    mysql = { "sql_formatter" },
    blade = { "blade-formatter" },
  },
  -- Custom formatters and changes to built-in formatters
  formatters = {
    blade = { "blade-formatter" },
    -- # Example of using dprint only when a dprint.json file is present
    -- dprint = {
    --   condition = function(ctx)
    --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
    --   end,
    -- },
    --
    -- # Example of using shfmt with extra args
    -- shfmt = {
    --   prepend_args = { "-i", "2", "-ci" },
    -- },
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if not (vim.g.autoformat or vim.b[bufnr].autoformat) then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  dependencies = { "mason.nvim" },
  cmd = "ConformInfo",
  keys = {
    -- stylua: ignore start
    { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format" },
    { "<leader>tf", "<cmd>FormatToggle<cr>", desc = "Toggle Format on Save" },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = opts,
}
