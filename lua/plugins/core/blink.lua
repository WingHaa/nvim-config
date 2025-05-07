local M = {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts_extend = { "sources.completion.enabled_providers" },
}

M.dependencies = {
    {
        "saghen/blink.compat",
        opts = {
            impersonate_nvim_cmp = false,
            enable_events = false,
            debug = false,
        },
    },
    -- {
    --     "Exafunction/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     cmd = "Codeium",
    --     build = ":Codeium Auth",
    --     opts = {},
    -- },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    { "fang2hou/blink-copilot" },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

                local extends = {
                    typescript = { "tsdoc" },
                    javascript = { "jsdoc" },
                    lua = { "luadoc" },
                    python = { "pydoc" },
                    rust = { "rustdoc" },
                    cs = { "csharpdoc" },
                    java = { "javadoc" },
                    c = { "cdoc" },
                    cpp = { "cppdoc" },
                    php = { "phpdoc" },
                    kotlin = { "kdoc" },
                    ruby = { "rdoc" },
                    sh = { "shelldoc" },
                }
                -- friendly-snippets - enable standardized comments snippets
                for ft, snips in pairs(extends) do
                    require("luasnip").filetype_extend(ft, snips)
                end
            end,
        },
        opts = { history = true, delete_check_events = "TextChanged" },
    },
}

M.opts = {
    keymap = { preset = "enter" },
    -- snippets = { preset = "luasnip" },
    completion = {
        list = {
            max_items = 200,
            selection = {
                preselect = false,
                auto_insert = false,
            },
        },

        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },

        ghost_text = {
            enabled = true,
        },

        accept = {
            auto_brackets = {
                enabled = true,
            },
        },

        menu = {
            draw = {
                columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            },
        },
    },

    signature = {
        enabled = true,
    },

    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "dadbod",
            -- "codeium",
            "lazydev",
            "copilot",
        },

        min_keyword_length = function()
            return vim.bo.filetype == "markdown" and 2 or 0
        end,

        providers = {
            lsp = {
                name = "LSP",
                module = "blink.cmp.sources.lsp",
                transform_items = function(_, items)
                    return vim.tbl_filter(function(item)
                        return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
                    end, items)
                end,
                score_offset = 1,
            },
            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            -- codeium = {
            --     name = "codeium",
            --     module = "blink.compat.source",
            --     score_offset = -3,
            --     max_items = 4,
            -- },
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            copilot = {
                name = "copilot",
                module = "blink-copilot",
                score_offset = -3,
                async = true,
            },
        },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
    },
}

M.config = function(_, opts)
    require("blink.cmp").setup(opts)
end

return M
