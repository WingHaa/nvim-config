local langs = {
    "bash",
    "c",
    "css",
    "docker",
    "go",
    -- "javascript",
    "json",
    "lua",
    "nginx",
    "php",
    "python",
    "sql",
    "toml",
    "yaml",
}

local M = {
    "neovim/nvim-lspconfig",
}

M.dependencies = {
    "williamboman/mason.nvim",
    "saghen/blink.cmp",
}

local function setup_lsp_keymap()
    local map = vim.keymap
    local desc = require("lib.keymap").desc
    map.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc("Current Line Diagnostic"))
    map.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc("Prev Diagnostic"))
    map.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc("Next Diagnostic"))
    -- map.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc("Code Actions"))

    map.set({ "n", "v" }, "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", desc("Code Actions"))
    map.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", desc("Definitions"))
    map.set("n", "gD", "<cmd>FzfLua lsp_declarations<CR>", desc("Declarations"))
    map.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", desc("Implementations"))
    map.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", desc("References"))
    map.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", desc("Type definition"))
    map.set("n", "<leader>lc", "<cmd>FzfLua lsp_incoming_calls<CR>", desc("Incoming Calls"))
    map.set("n", "<leader>lC", "<cmd>FzfLua lsp_outgoing_calls<CR>", desc("Outgoing Calls"))
    map.set("n", "<leader>ld", "<cmd>FzfLua diagnostics_document<CR>", desc("Document Diagnostic"))
    map.set("n", "<leader>lD", "<cmd>FzfLua diagnostics_workspace<CR>", desc("Workspace Diagnostic"))
    map.set("n", "<leader>ls", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc("Symbols"))
    map.set("n", "<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", desc("Live Symbols"))

    map.set("n", "<leader>lr", "<cmd>LspRestart<CR>", desc("Restart LSP Server"))
    map.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc("Hover Definition"))
    map.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc("Rename Symbol"))
    map.set("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc("Signature Help"))
end

local lsp_opts = {
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

function M.config()
    vim.diagnostic.config(lsp_opts)
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_buffer_sync", { clear = true }),
        callback = setup_lsp_keymap,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("blink.cmp").get_lsp_capabilities(default_capabilities)
    for _, lang in pairs(langs) do
        require("plugins.lsp.lang." .. lang).setup(capabilities)
    end
end

return M
