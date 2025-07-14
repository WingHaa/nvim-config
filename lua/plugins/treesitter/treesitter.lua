local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = "VeryLazy",
    build = ":TSUpdate",
}

M.opts = {
    indent = {
        enable = true,
    },
    ensure_installed = {
        "blade",
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
        "sql",
        "go",
    },
    auto_install = true,
    install_dir = vim.fn.stdpath("data") .. "/site",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
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
    -- vim.g._ts_force_sync_parsing = true -- https://github.com/neovim/neovim/issues/32660
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(details)
            local bufnr = details.buf
            if not pcall(vim.treesitter.start, bufnr) then
                return
            end
            vim.bo[bufnr].syntax = "on" -- Use regex based syntax-highlighting as fallback as some plugins might need it
            -- vim.wo.foldmethod = "expr"
            -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folds
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Use treesitter for indentation
        end,
    })
    local already_installed = require("nvim-treesitter.config").get_installed()
    local parsers_to_install = vim.iter(opts.ensure_installed)
        :filter(function(parser)
            return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()
    require("nvim-treesitter").install(parsers_to_install)
    require("nvim-treesitter").setup(opts)
end

return M
