return {
    { "rhysd/vim-go-impl", ft = "go", cmd = { "GoImpl", "Impl" } },
    {
        "buoto/gotests-vim",
        ft = "go",
        cmd = { "GoTests", "GoTestsAll" },
        config = function()
            local ok, registry = pcall(require, "mason-registry")
            if not ok then
                vim.notify("Failed to load mason-registry", vim.log.levels.ERROR)
            end

            vim.g.gotests_bin = require("lib.mason").path.bin("gotests")
        end,
    },
}
