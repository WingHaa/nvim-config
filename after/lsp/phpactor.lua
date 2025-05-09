return {
    filetypes = { "php" },
    settings = {
        phpactor = {
            language_server_phpstan = { enabled = false },
            language_server_psalm = { enabled = false },
            inlayHints = {
                enable = true,
                parameterHints = false,
                typeHints = true,
            },
        },
    },
}
