return {
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    root_dir = function()
        return vim.loop.cwd()
    end,
}
