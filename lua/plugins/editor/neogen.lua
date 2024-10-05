local wk = require("lib.keymap").wk_desc
local desc = require("lib.keymap").desc
return {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("neogen").setup()
    end,
    keys = {
        wk({ "<leader>nf", "<cmd>Neogen func<CR>", "n" }, desc("Generate Docs")),
    },
    -- Follow only stable versions
    version = "*",
}
