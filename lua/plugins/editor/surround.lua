return {
    "nvim-mini/mini.surround",
    version = "*",
    opts = {
        -- Add custom surroundings to be used on top of builtin ones. For more
        -- information with examples, see `:h MiniSurround.config`.
        custom_surroundings = nil,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            add = "ys",
            delete = "ds",
            find = "",
            find_left = "",
            highlight = "",
            replace = "cs",
            update_n_lines = "",

            -- Add this only if you don't want to use extended mappings
            suffix_last = "",
            suffix_next = "",
        },

        -- Number of lines within which surrounding is searched
        n_lines = 20,

        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        -- see `:h MiniSurround.config`.
        search_method = "cover_or_next",

        -- Whether to disable showing non-error feedback
        silent = true,
    },
    config = function(_, opts)
        local ts_input = require("mini.surround").gen_spec.input.treesitter
        local surroundings = {
            custom_surroundings = {
                f = {
                    input = ts_input({ outer = "@call.outer", inner = "@call.inner" }),
                },
            },
        }

        require("mini.surround").setup(vim.tbl_deep_extend("force", opts, surroundings))
        vim.keymap.del("x", "ys")
        vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

        -- Make special mapping for "add surrounding for line"
        vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
}
