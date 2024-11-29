return {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>lfs", ":FlutterRun <CR>", {})
        vim.keymap.set("n", "<leader>lfq", ":FlutterQuit <CR>", {})
        vim.keymap.set("n", "<leader>lfr", ":FlutterRestart <CR>", {})
        vim.keymap.set("n", "<leader>lr", ":FlutterLspRestart <CR>", {})
        vim.keymap.set("n", "<leader>lfd", ":FlutterDevTools <CR>", {})

        require("flutter-tools").setup({
            decorations = {
                statusline = {
                    app_version = true,
                    device = true,
                },
            },
            dev_tools = {
                autostart = true,
                auto_open_browser = true,
            },
            lsp = {
                color = {
                    enabled = true,
                    background = true,
                    background_color = { r = 19, g = 17, b = 24 },
                    virtual_text = false,
                },
            },
        })
    end,
}
