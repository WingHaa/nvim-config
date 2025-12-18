return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git_branch",
        icons = true,
        status = true,
    },
    keys = function()
        local k = {
            { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
            { "<leader>h", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
            { "<M-k>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
            { "<M-j>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
        }

        for i = 1, 9 do
            table.insert(k, { "<leader>" .. i, "<cmd>Grapple select index=" .. i .. "<cr>" })
        end
        return k
    end,
}
