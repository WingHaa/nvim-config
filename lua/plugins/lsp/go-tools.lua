return {
    { "rhysd/vim-go-impl", ft = "go", cmd = { "GoImpl", "Impl" } },
    {
        "buoto/gotests-vim",
        ft = "go",
        cmd = { "GoTests", "GoTestsAll" },
        config = function()
            local ok, Path = pcall(require, "plenary.path")
            if not ok then
                vim.notify("Failed to load plenary", vim.log.levels.ERROR)
            end

            vim.g.gotests_bin = Path:new(vim.fn.stdpath("data") .. "/mason/bin/gotests"):absolute()
        end,
    },
}
