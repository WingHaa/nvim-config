return {
    "olimorris/codecompanion.nvim",
    cmd = {
        "CodeCompanion",
        "CodeCompanionActions",
        "CodeCompanionChat",
        "CodeCompanionCmd",
    },
    opts = {
        keymaps = {
            options = {
                modes = {
                    n = "g?",
                },
                callback = "keymaps.options",
                description = "Options",
                hide = true,
            },
            regenerate = {
                modes = {
                    n = "gR",
                },
                index = 3,
                callback = "keymaps.regenerate",
                description = "Regenerate the last response",
            },
        },
        opts = {
            blank_prompt = [[
You are an agent - please keep going until the user’s query is completely resolved, before ending your turn and yielding back to the user. Only terminate your turn when you are sure that the problem is solved.
If you are not sure about file content or codebase structure pertaining to the user’s request, use your tools to read files and gather the relevant information: do NOT guess or make up an answer.
You MUST plan extensively before each function call, and reflect extensively on the outcomes of the previous function calls. DO NOT do this entire process by making function calls only, as this can impair your ability to solve the problem and think insightfully.
            ]], -- The prompt to use when the user doesn't provide a prompt
            register = '"', -- The register to use for yanking code
            yank_jump_delay_ms = 400, -- Delay in milliseconds before jumping back from the yanked code
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
