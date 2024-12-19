local desc = require("lib.keymap").desc
local wk = require("lib.keymap").wk_desc
local M = {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
}

M.keys = {
    wk({ "<leader>ff", "<cmd>FzfLua files<CR>", "n" }, desc("Files")),
    --stylua: ignore
    wk({ "<leader>fF", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') })<CR>" }, desc("cwd files")),
    wk({ "<leader>fg", "<cmd>FzfLua live_grep<CR>" }, desc("Live grep")),
    wk({ "<leader>fG", "<cmd>FzfLua grep<CR>" }, desc("Grep pattern")),
    wk({ "<leader>fo", "<cmd>FzfLua oldfiles<CR>" }, desc("Recent files")),
    wk({ "<leader>fb", "<cmd>FzfLua buffers<CR>" }, desc("Buffers")),
    wk({ "<leader>fk", "<cmd>FzfLua keymaps<CR>" }, desc("Keymaps")),
    wk({ "<leader>fw", "<cmd>FzfLua grep_cword<CR>" }, desc("word at cursor")),
    wk({ "<leader>fw", "<cmd>FzfLua grep_visual<CR>", mode = "v" }, desc("visual word")),
    wk({ "<leader>fW", "<cmd>FzfLua grep_cWORD<CR>" }, desc("WORD at cursor")),
    wk({ "<leader>fm", "<cmd>FzfLua marks<CR>" }, desc("Marks")),
    wk({ "<leader>fq", "<cmd>FzfLua quickfix_stack<CR>" }, desc("Quickfix list")),
    wk({ "<leader>fl", "<cmd>FzfLua loclist_stack<CR>" }, desc("Location list")),
    wk({ "<leader>fr", "<cmd>FzfLua resume<CR>" }, desc("Resume")),
    wk({ "<leader>fR", "<cmd>FzfLua registers<CR>" }, desc("Registers")),
    wk({ "<leader>fh", "<cmd>FzfLua help_tags<CR>" }, desc("Help tags")),
    wk({ "<leader>fc", "<cmd>FzfLua colorschemes<CR>" }, desc("Colorscheme")),

    wk({ "<leader>sc", "<cmd>FzfLua commands<CR>" }, desc("Commands")),
    wk({ "<leader>sh", "<cmd>FzfLua command_history<cR>" }, desc("Command History")),

    wk({ "<leader>gb", "<cmd>FzfLua git_bcommits<CR>" }, desc("Buffer's commit")),
    wk({ "<leader>gc", "<cmd>FzfLua git_commits<CR>" }, desc("Commit")),
    wk({ "<leader>gf", "<cmd>FzfLua git_files<CR>" }, desc("Git file")),
    wk({ "<leader>gt", "<cmd>FzfLua git_tags<CR>" }, desc("Git tag")),
}

M.config = function()
    local actions = require("fzf-lua.actions")
    local fzflua = require("fzf-lua")
    local utils = fzflua.utils
    local function hl_validate(hl)
        return not utils.is_hl_cleared(hl) and hl or nil
    end

    fzflua.setup({
        fzf_opts = { ["--layout"] = "default", ["--marker"] = "+" },
        winopts = {
            width = 0.8,
            height = 0.9,
            preview = {
                default = (vim.fn.executable("batcat") or vim.fn.executable("cat")) and "bat" or "builtin",
                hidden = "nohidden",
                vertical = "up:45%",
                horizontal = "right:50%",
                layout = "vertical",
                flip_columns = 120,
                delay = 10,
                winopts = { number = false },
            },
        },
        previewers = {
            builtin = {
                syntax_limit_b = 1024 * 100, -- 100KB
            },
            bat = {
                cmd = vim.fn.executable("batcat") == 1 and "batcat" or "bat",
                args = "--color=always --style=numbers,changes",
                -- uncomment to set a bat theme, `bat --list-themes`
                theme = "OneHalfDark",
            },
        },
        hls = {
            normal = hl_validate("TelescopeNormal"),
            border = hl_validate("TelescopeBorder"),
            title = hl_validate("TelescopePromptTitle"),
            help_normal = hl_validate("TelescopeNormal"),
            help_border = hl_validate("TelescopeBorder"),
            preview_normal = hl_validate("TelescopeNormal"),
            preview_border = hl_validate("TelescopeBorder"),
            preview_title = hl_validate("TelescopePreviewTitle"),
            -- builtin preview only
            cursor = hl_validate("Cursor"),
            cursorline = hl_validate("TelescopeSelection"),
            cursorlinenr = hl_validate("TelescopeSelection"),
            search = hl_validate("IncSearch"),
        },
        lsp = {
            jump_to_single_result = true,
            jump_to_single_result_action = actions.file_edit,
        },
        fzf_colors = {
            ["fg"] = { "fg", "TelescopeNormal" },
            ["bg"] = { "bg", "TelescopeNormal" },
            ["hl"] = { "fg", "TelescopeMatching" },
            ["fg+"] = { "fg", "TelescopeSelection" },
            ["bg+"] = { "bg", "TelescopeSelection" },
            ["hl+"] = { "fg", "TelescopeMatching" },
            ["info"] = { "fg", "TelescopeMultiSelection" },
            ["border"] = { "fg", "TelescopeBorder" },
            ["gutter"] = "-1",
            ["query"] = { "fg", "TelescopePromptNormal" },
            ["prompt"] = { "fg", "TelescopePromptPrefix" },
            ["pointer"] = { "fg", "TelescopeSelectionCaret" },
            ["marker"] = { "fg", "TelescopeSelectionCaret" },
            ["header"] = { "fg", "TelescopeTitle" },
        },
        keymap = {
            builtin = {
                true,
                ["<C-d>"] = "preview-page-down",
                ["<C-u>"] = "preview-page-up",
            },
            fzf = {
                true,
                ["ctrl-d"] = "preview-page-down",
                ["ctrl-u"] = "preview-page-up",
                ["ctrl-q"] = "select-all+accept",
            },
        },
        actions = {
            files = {
                ["enter"] = actions.file_edit_or_qf,
                ["ctrl-s"] = actions.file_split,
                ["ctrl-v"] = actions.file_vsplit,
                ["ctrl-t"] = actions.file_tabedit,
                ["alt-q"] = actions.file_sel_to_qf,
            },
            grep = {
                ["ctrl-g"] = { actions.grep_lgrep },
                ["ctrl-y"] = { actions.toggle_hidden },
            },
        },
        buffers = {
            keymap = { builtin = { ["<C-d>"] = false } },
            actions = { ["ctrl-x"] = false, ["ctrl-d"] = { actions.buf_del, actions.resume } },
        },
        files = {
            cwd_prompt = false,
        },
        grep = {
            rg_glob = true, -- default to glob parsing?
            glob_flag = "--iglob", -- for case sensitive globs use '--glob'
            glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
        },
        oldfiles = {
            include_current_session = true,
        },
        marks = {
            marks = "%a",
        },
    })
    fzflua.register_ui_select()
end

return M
