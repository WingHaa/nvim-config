return {
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim", "Snacks" },
            },
        },
    },
}
