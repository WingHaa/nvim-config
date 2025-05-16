return {
    "gbprod/substitute.nvim",
    opts = {
        on_substitute = nil,
        yank_substituted_text = false,
        preserve_cursor_position = false,
        modifiers = nil,
        highlight_substituted_text = {
            enabled = true,
            timer = 100,
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
    },
    keys = {
        -- stylua: ignore start
        { "gr", function() require("substitute").operator() end, },
        { "grr", function() require("substitute").line() end, },
        { "gR", function() require("substitute").eol() end, },
        { "gr", function() require("substitute").visual() end, mode = { "x", "v" }, },
        { "<leader>gr", function() require("substitute").operator({ register = "+" }) end, },
        { "<leader>grr", function() require("substitute").line({ register = "+" }) end, },
        { "<leader>gR", function() require("substitute").eol({ register = "+" }) end, },
        { "<leader>gr", function() require("substitute").visual({ register = "+" }) end, mode = { "x", "v" }, },
    },
}
