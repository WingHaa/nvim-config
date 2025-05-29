return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
        },
    },
    config = function(_, opts)
        require("nvim-treesitter-textobjects").setup(opts)

        -- You can use the capture groups defined in `textobjects.scm`
        local selector = require("nvim-treesitter-textobjects.select")
        local mover = require("nvim-treesitter-textobjects.move")
        vim.keymap.set({ "x", "o" }, "af", function()
            selector.select_textobject("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "if", function()
            selector().select_textobject("@function.inner", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ac", function()
            selector.select_textobject("@class.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ic", function()
            selector.select_textobject("@class.inner", "textobjects")
        end)
        -- You can also use captures from other query groups like `locals.scm`
        vim.keymap.set({ "x", "o" }, "as", function()
            selector.select_textobject("@local.scope", "locals")
        end)

        vim.keymap.set({ "n", "x", "o" }, "]m", function()
            mover.goto_next_start("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "]]", function()
            mover.goto_next_start("@class.outer", "textobjects")
        end)
        -- You can also pass a list to group multiple queries.
        vim.keymap.set({ "n", "x", "o" }, "]o", function()
            mover.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
        end)
        -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
        vim.keymap.set({ "n", "x", "o" }, "]s", function()
            mover.goto_next_start("@local.scope", "locals")
        end)
        vim.keymap.set({ "n", "x", "o" }, "]z", function()
            mover.goto_next_start("@fold", "folds")
        end)
        vim.keymap.set({ "n", "x", "o" }, "]M", function()
            mover.goto_next_end("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "][", function()
            mover.goto_next_end("@class.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "[m", function()
            mover.goto_previous_start("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "[[", function()
            mover.goto_previous_start("@class.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "[M", function()
            mover.goto_previous_end("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "[]", function()
            mover.goto_previous_end("@class.outer", "textobjects")
        end)
    end,
}
