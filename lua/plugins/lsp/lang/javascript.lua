local desc = require("util.keymap").desc
local M = {}

M.setup = function(capabilities)
  local lspconfig = require("lspconfig")

  lspconfig.tsserver.setup({
    capabilities = capabilities,
    filetypes = {
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
    },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
    handlers = {
      ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
        if result.diagnostics == nil then
          return
        end

        -- ignore some tsserver diagnostics
        local idx = 1
        while idx <= #result.diagnostics do
          local entry = result.diagnostics[idx]

          local formatter = require("format-ts-errors")[entry.code]
          entry.message = formatter and formatter(entry.message) or entry.message

          -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
          if entry.code == 80001 then
            -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
            table.remove(result.diagnostics, idx)
          else
            idx = idx + 1
          end
        end

        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
      end,
    },
  })

  vim.keymap.set(
    "n",
    "<Leader>oi",
    "<cmd>lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<CR>",
    desc("Organize Imports")
  )
end

return M
