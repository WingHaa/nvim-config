local M = {
    "saghen/blink.cmp",
    version = "v0.*",
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
}

M.opts = {
    keymap = { preset = "enter" },

    highlight = {
        ns = vim.api.nvim_create_namespace("blink_cmp"),
        use_nvim_cmp_as_default = true,
    },

    blocked_filetypes = {},

    kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰆦",
        Property = "󰖷",

        Class = "󱡠",
        Interface = "󱡠",
        Struct = "󱡠",
        Module = "󰅩",

        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        EnumMember = "󰦨",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",

        -- Codeium = "",
    },
}

M.opts.windows = {
    autocomplete = {
        min_width = 15,
        max_height = 10,
        border = "none",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        scrolloff = 2,
        scrollbar = true,
        direction_priority = { "s", "n" },
        auto_show = true,
        selection = "manual",
        draw = {
            align_to_component = "label", -- or 'none' to disable
            padding = 1,
            gap = 1,

            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            components = {
                kind_icon = {
                    ellipsis = false,
                    text = function(ctx)
                        return ctx.kind_icon .. ctx.icon_gap
                    end,
                    highlight = function(ctx)
                        return (require("blink.cmp.utils").get_tailwind_hl(ctx) or "BlinkCmpKind") .. ctx.kind
                    end,
                },

                kind = {
                    ellipsis = false,
                    width = { fill = true },
                    text = function(ctx)
                        return ctx.kind
                    end,
                    highlight = function(ctx)
                        return (require("blink.cmp.utils").get_tailwind_hl(ctx) or "BlinkCmpKind") .. ctx.kind
                    end,
                },

                label = {
                    width = { fill = true, max = 60 },
                    text = function(ctx)
                        return ctx.label .. ctx.label_detail
                    end,
                    highlight = function(ctx)
                        -- label and label details
                        local highlights = {
                            { 0, #ctx.label, group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel" },
                        }
                        if ctx.label_detail then
                            table.insert(
                                highlights,
                                { #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" }
                            )
                        end

                        -- characters matched on the label by the fuzzy matcher
                        for _, idx in ipairs(ctx.label_matched_indices) do
                            table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                        end

                        return highlights
                    end,
                },

                label_description = {
                    width = { max = 30 },
                    text = function(ctx)
                        return ctx.label_description
                    end,
                    highlight = "BlinkCmpLabelDescription",
                },
            },
        },
        cycle = {
            from_bottom = true,
            from_top = true,
        },
    },
    documentation = {
        min_width = 10,
        max_width = 60,
        max_height = 20,
        border = "padded",
        winblend = 0,
        scrollbar = true,
        direction_priority = {
            autocomplete_north = { "e", "w", "n", "s" },
            autocomplete_south = { "e", "w", "s", "n" },
        },
        auto_show = true,
        auto_show_delay_ms = 500,
        update_delay_ms = 50,
    },
    signature_help = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "padded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        scrollbar = false,
        direction_priority = { "n", "s" },
    },
    ghost_text = {
        enabled = true,
    },
}

M.opts.sources = {
    completion = {
        enabled_providers = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "luasnip",
            "dadbod",
            -- "codeium",
            "lazydev",
        },
    },

    providers = {
        lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            enabled = true, -- whether or not to enable the provider
            transform_items = nil, -- function to transform the items before they're returned
            should_show_items = true, -- whether or not to show the items
            max_items = nil, -- maximum number of items to return
            min_keyword_length = 0, -- minimum number of characters to trigger the provider
            fallback_for = { "lazydev" }, -- if any of these providers return 0 items, it will fallback to this provider
            score_offset = 0, -- boost/penalize the score of the items
            override = nil, -- override the source's functions
        },
        path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            opts = {
                trailing_slash = false,
                label_trailing_slash = true,
                get_cwd = function(context)
                    return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                end,
                show_hidden_files_by_default = false,
            },
        },
        snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            score_offset = -3,
            opts = {
                friendly_snippets = false,
                search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                global_snippets = { "all" },
                extended_filetypes = {},
                ignored_filetypes = {},
            },
        },
        buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            fallback_for = { "lsp" },
        },
        luasnip = {
            name = "luasnip",
            module = "blink.compat.source",
        },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        -- codeium = {
        --     name = "codeium",
        --     module = "blink.compat.source",
        --     score_offset = -3,
        --     max_items = 4,
        -- },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
    },
}

M.opts.accept = {
    create_undo_point = true,
    -- expand_snippet = vim.snippet.expand,
    expand_snippet = require("luasnip").lsp_expand,

    auto_brackets = {
        enabled = false,
        default_brackets = { "(", ")" },
        override_brackets_for_filetypes = {},
        force_allow_filetypes = {},
        blocked_filetypes = {},
        kind_resolution = {
            enabled = true,
            blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
        },
        semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = {},
            timeout_ms = 400,
        },
    },
}

M.opts.trigger = {
    completion = {
        keyword_range = "prefix",
        keyword_regex = "[%w_\\-]",
        exclude_from_prefix_regex = "[\\-]",
        blocked_trigger_characters = { " ", "\n", "\t" },
        show_on_accept_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        show_on_x_blocked_trigger_characters = { "'", '"', "(" },
        show_in_snippet = true,
    },

    signature_help = {
        enabled = true,
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        show_on_insert_on_trigger_character = true,
    },
}

M.opts.fuzzy = {
    use_frecency = true,
    use_proximity = true,
    max_items = 200,
    sorts = { "label", "kind", "score" },

    prebuilt_binaries = {
        download = true,
        force_version = nil,
        force_system_triple = nil,
    },
}

M.config = function(_, opts)
    opts.accept.expand_snippet = require("luasnip").lsp_expand
    require("blink.cmp").setup(opts)
end

return M
