return {
    "carlos-algms/agentic.nvim",

    dependencies = {
        "hakonharnes/img-clip.nvim",
    },

    opts = {
        -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp"
        provider = "claude-acp",
        keymaps = {
            -- Keybindings for ALL buffers in the widget (chat, prompt, code, files)
            widget = {
                close = "q", -- String for a single keybinding
                change_mode = {
                    {
                        "<S-Tab>",
                        mode = { "i", "n", "v" }, -- Specify modes for this keybinding
                    },
                },
            },

            -- Keybindings for the prompt buffer only
            prompt = {
                submit = {
                    "<CR>", -- Normal mode, just Enter
                    {
                        "<C-s>",
                        mode = { "n", "v", "i" },
                    },
                },

                paste_image = {
                    {
                        "<C-p>",
                        mode = { "n", "i" }, -- I like normal and insert modes for this, but feel free to customize
                    },
                },
            },

            -- Keybindings for diff preview navigation
            diff_preview = {
                next_hunk = "]c",
                prev_hunk = "[c",
            },
        },
    },

    keys = {
        {
            "<leader>co",
            function()
                require("agentic").toggle()
            end,
            mode = { "n", "v" },
            desc = "Claude Open",
        },
        {
            "<leader>cr",
            function()
                require("agentic").add_selection_or_file_to_context({ focus_prompt = false })
            end,
            mode = { "n", "v" },
            desc = "Claude reference",
        },
    },
}
