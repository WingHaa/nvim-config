return {
    on_attach = function(client, bufnr)
        vim.keymap.set(
            "n",
            "<Leader>oi",
            "<cmd>lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<CR>",
            {
                buffer = bufnr,
                desc = "Organize Imports",
            }
        )
    end,
    filetypes = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
    },
    -- root_dir = function(fname)
    --     local util = require("lspconfig.util")
    --     return util.root_pattern("package.json", "tsconfig.json", ".git")(fname) or util.find_git_ancestor(fname)
    -- end,
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
}
