local L = { "https://codeberg.org/andyg/leap.nvim.git", keys = { "s", "S" } }

L.opts = {
    max_phase_one_targets = nil,
    highlight_unlabeled_phase_one_targets = false,
    max_highlighted_traversal_targets = 10,
    equivalence_classes = { " \t\r\n" },
    substitute_chars = {},
    safe_labels = "fnut/SFNLHMUGTZ?",
    labels = "bcdefghijklmnopqrstuvwxyz",
    special_keys = {
        next_target = "<enter>",
        prev_target = "<tab>",
        next_group = "<space>",
        prev_group = "<tab>",
        multi_accept = "<enter>",
        multi_revert = "<backspace>",
    },
}

L.config = function(_, opts)
    require("leap").setup(opts)
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
    vim.keymap.set({ "n", "x", "o" }, "R", require("lib.ts-selector"))
    vim.keymap.set({ "n", "x", "o" }, "gs", function()
        require("leap.remote").action()
    end)

    local function ft(key_specific_args)
        require("leap").leap(vim.tbl_deep_extend("keep", key_specific_args, {
            inputlen = 1,
            inclusive = true,
            opts = {
                -- Force autojump.
                labels = "",
                -- Match the modes where you don't need labels (`:h mode()`).
                safe_labels = vim.fn.mode(1):match("o") and "" or nil,
            },
        }))
    end

    -- A helper function making it easier to set "clever-f" behavior
    -- (using f/F or t/T instead of ;/, - see the plugin clever-f.vim).
    local clever = require("leap.user").with_traversal_keys
    -- local clever_f = clever("f", "F")
    local clever_t = clever("t", "T")

    -- vim.keymap.set({ "n", "x", "o" }, "f", function()
    --     ft({ opts = clever_f })
    -- end)
    -- vim.keymap.set({ "n", "x", "o" }, "F", function()
    --     ft({ backward = true, opts = clever_f })
    -- end)
    vim.keymap.set({ "n", "x", "o" }, "t", function()
        ft({ offset = -1, opts = clever_t })
    end)
    vim.keymap.set({ "n", "x", "o" }, "T", function()
        ft({ backward = true, offset = 1, opts = clever_t })
    end)
end

return { L }
