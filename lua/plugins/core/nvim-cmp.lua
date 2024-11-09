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
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "Codeium",
        build = ":Codeium Auth",
        opts = {},
    },
}

M.opts = {
    keymap = { preset = "enter" },
    completion = {
        trigger = {
            list = {
                max_items = 200,
                selection = "manual",
            },

            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },

            ghost_text = {
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
        default = { "lsp", "path", "snippets", "buffer" },
        cmdline = {},

        min_keyword_length = function()
            return vim.bo.filetype == "markdown" and 2 or 0
        end,

        completion = {
            enabled_providers = {
                "lsp",
                "path",
                "snippets",
                "buffer",
                "luasnip",
                "dadbod",
                "codeium",
                "lazydev",
            },
        },

        providers = {
            lsp = {
                name = "LSP",
                module = "blink.cmp.sources.lsp",
                transform_items = function(_, items)
                    return vim.tbl_filter(function(item)
                        return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
                    end, items)
                end,
            },
            snippets = {
                name = "Snippets",
                module = "blink.cmp.sources.snippets",
                opts = {
                    friendly_snippets = false,
                    search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                    global_snippets = { "all" },
                    extended_filetypes = {},
                    ignored_filetypes = {},
                    get_filetype = function(context)
                        return vim.bo.filetype
                    end,
                },
            },
            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            codeium = {
                name = "codeium",
                module = "blink.compat.source",
                score_offset = -3,
                max_items = 4,
            },
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
    },
}

M.config = function(_, opts)
    require("blink.cmp").setup(opts)
end

return M
