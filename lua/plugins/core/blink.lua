local M = {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
}

M.dependencies = {
    {
        "fang2hou/blink-copilot",
        lazy = true,
        dependencies = {
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
    },
}

M.opts = {
    keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" }, -- make it so CR expand snippet with tabstop
    },
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

return M
