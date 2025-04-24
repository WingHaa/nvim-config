return {
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.PaperColor_Theme_Options = {
            theme = {
                ["default.dark"] = {
                    override = {
                        spellbad = { "NONE", "NONE" },
                        spellcap = { "NONE", "NONE" },
                        spellrare = { "NONE", "NONE" },
                        spelllocal = { "NONE", "NONE" },
                    },
                },
                ["default.light"] = {
                    override = {
                        spellbad = { "NONE", "NONE" },
                        spellcap = { "NONE", "NONE" },
                        spellrare = { "NONE", "NONE" },
                        spelllocal = { "NONE", "NONE" },
                    },
                },
            },
        }
    end,
}
