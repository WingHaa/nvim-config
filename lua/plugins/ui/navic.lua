local icons = require("lib.icons")
return {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    init = function()
        vim.o.winbar = " %{%v:lua.require'nvim-navic'.get_location()%}"
    end,
    opts = {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        lazy_update_context = true,
        icons = icons.kinds,
    },
}
