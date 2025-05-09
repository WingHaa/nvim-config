local function lsp_keymap()
    local map = vim.keymap
    local desc = require("lib.keymap").desc
    map.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc("Current Line Diagnostic"))
    map.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc("Prev Diagnostic"))
    map.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc("Next Diagnostic"))
    map.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc("Code Actions"))
    map.set("n", "<leader>lr", "<cmd>LspRestart<CR>", desc("Restart LSP Server"))
    map.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc("Hover Definition"))
    map.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc("Rename Symbol"))
    map.set("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc("Signature Help"))
end

local function navic(c, b)
    local ok, n = pcall(require, "nvim-navic")
    if ok and c and c.supports_method("textDocument/documentSymbol") then
        n.attach(c, b)
    end
end

local function lsp_highlight(client, bufnr)
    if not client or not client.server_capabilities.documentHighlightProvider then
        return
    end

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

local function setup(e)
    local bufnr = e.buf
    local client = vim.lsp.get_client_by_id(e.data.client_id)
    lsp_keymap()
    navic(client, bufnr)
    lsp_highlight(client, bufnr)
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        vim.diagnostic.config({
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
        })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspAttach_buffer_sync", { clear = true }),
            callback = setup,
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

        -- Add custom blade lsp
        require("lspconfig.configs").blade_ls = {
            default_config = {
                name = "blade_ls",
                cmd = { vim.fn.expand("$HOME/repo/tools/laravel-dev-tools/builds/laravel-dev-tools"), "lsp" },
                filetypes = { "blade" },
                root_dir = function(pattern)
                    local util = require("lspconfig.util")
                    local cwd = vim.loop.cwd()
                    local root = util.root_pattern("composer.json")(pattern)

                    -- prefer cwd if root is a descendant
                    return util.path.is_descendant(cwd, root) and cwd or root
                end,
                settings = {},
            },
        }

        local default_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities(default_capabilities)
        vim.lsp.config("*", { capabilities = capabilities })

        vim.lsp.enable({
            "basedpyright",
            "bashls",
            "blade_ls",
            "clangd",
            "docker_compose_language_service",
            "dockerls",
            "emmlet_ls",
            "gopls",
            "jsonls",
            "lua_ls",
            "nginx_language_server",
            "phpactor",
            "prismals",
            "sqlls",
            "tailwindcss",
            "taplo",
            "ts_ls",
            "yamlls",
        })
    end,
}
