return {
    "hedyhli/outline.nvim",
    config = function()
        require("outline").setup({})
    end,
    cmd = "Outline",
    keys = {
        { "<leader>so", "<cmd>Outline<CR>", desc = "Toggle Outline" },
    },
}
