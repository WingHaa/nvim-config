return {
  "mfussenegger/nvim-lint",
  ft = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
  },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = {
        "eslint_d",
      },
      typescript = {
        "eslint_d",
      },
      javascriptreact = {
        "eslint_d",
      },
      typescriptreact = {
        "eslint_d",
      },
      php = {
        "phpcs",
      },
    }

    require("lint").linters.phpcs.args = {
      "-q",
      "--standard=phpcs.xml",
      "--report=json",
      "-",
    }

    vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave", "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
