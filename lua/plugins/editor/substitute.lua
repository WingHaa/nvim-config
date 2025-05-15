return {
    "gbprod/substitute.nvim",
    event = "BufRead",
    config = function()
        local sub = require("substitute")
        sub.setup({
            on_substitute = nil,
            yank_substituted_text = false,
            preserve_cursor_position = false,
            modifiers = nil,
            highlight_substituted_text = {
                enabled = true,
                timer = 500,
            },
            range = {
                prefix = "s",
                prompt_current_text = false,
                confirm = false,
                complete_word = false,
                subject = nil,
                range = nil,
                suffix = "",
                auto_apply = false,
                cursor_position = "end",
            },
            exchange = {
                motion = false,
                use_esc_to_cancel = true,
                preserve_cursor_position = false,
            },
        })

        vim.keymap.set("n", "gr", sub.operator, { noremap = true })
        vim.keymap.set("n", "grr", sub.line, { noremap = true })
        vim.keymap.set("n", "gR", sub.eol, { noremap = true })
        vim.keymap.set("x", "gr", sub.visual, { noremap = true })
        vim.keymap.set(
            "n",
            "<leader>gr",
            "<cmd>lua require('substitute').operator({register='+'})<CR>",
            { noremap = true }
        )
        vim.keymap.set(
            "n",
            "<leader>grr",
            "<cmd>lua require('substitute').line({register='+'})<CR>",
            { noremap = true }
        )
        vim.keymap.set("n", "<leader>gR", "<cmd>lua require('substitute').eol({register='+'})<CR>", { noremap = true })
        vim.keymap.set(
            "x",
            "<leader>gr",
            "<cmd>lua require('substitute').visual({register='+'})<CR>",
            { noremap = true }
        )
    end,
}
