local M = {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
}

M.opts = {
    build = ":TSUpdate",
    indent = {
        enable = true,
    },
    autotag = {
        enable = true,
        filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "tsx",
            "jsx",
            "rescript",
            "css",
            "lua",
            "xml",
            "markdown",
        },
    },
    ensure_installed = {
        "markdown",
        "json",
        "javascript",
        "typescript",
        "yaml",
        "html",
        "css",
        "bash",
        "lua",
        "dockerfile",
        "gitignore",
        "vue",
        "jsdoc",
        "phpdoc",
        "http",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "<C-s>",
            node_incremental = "<C-s>",
            scope_incremental = false,
            node_decremental = "<BS>",
        },
    },
}

M.config = function(_, opts)
    vim.filetype.add({ pattern = { [".*%.blade%.php"] = "blade" } })
    vim.filetype.add({
        extension = {
            gohtml = "gotmpl",
            gotmpl = "gotmpl",
        },
    })

    require("nvim-treesitter.parsers").get_parser_configs().blade = {
        install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
        },
        filetype = "blade",
    }

    require("nvim-treesitter.configs").setup(opts)
end

return M
