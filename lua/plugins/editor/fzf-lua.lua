local desc = require("lib.keymap").desc
local wk = require("lib.keymap").wk_desc
local M = {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.keys = {
    wk({ "<leader>ff", "<cmd>FzfLua files<CR>", "n" }, desc("Find files")),
  --stylua: ignore
  wk({ "<leader>fF", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') })<CR>" }, desc("Find files")),
    wk({ "<leader>fg", "<cmd>FzfLua live_grep<CR>" }, desc("Live grep")),
    wk({ "<leader>fG", "<cmd>FzfLua grep<CR>" }, desc("Grep pattern")),
    wk({ "<leader>fo", "<cmd>FzfLua oldfiles<CR>" }, desc("Recent files")),
    wk({ "<leader>fb", "<cmd>FzfLua buffers<CR>" }, desc("Buffers")),
    wk({ "<leader>fk", "<cmd>FzfLua keymaps<CR>" }, desc("Keymaps")),
    wk({ "<leader>fw", "<cmd>FzfLua grep_cword<CR>", mode = "n" }, desc("word at cursor")),
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
    wk({ "<leader>sr", "<cmd>FzfLua lsp_references<cr>" }, desc("References")),
    wk({ "<leader>sd", "<cmd>FzfLua lsp_declarations<cr>" }, desc("Declarations")),
    wk({ "<leader>sD", "<cmd>FzfLua lsp_definitions<cr>" }, desc("Definitions")),
    wk({ "<leader>st", "<cmd>FzfLua lsp_typedefs<cr>" }, desc("Type Definitions")),
    wk({ "<leader>si", "<cmd>Fzflua lsp_implementations<cr>" }, desc("Implementations")),
    wk({ "<leader>sc", "<cmd>Fzflua lsp_incoming_calls<cr>" }, desc("Incoming Calls")),
    wk({ "<leader>sC", "<cmd>Fzflua lsp_outgoing_calls<cr>" }, desc("Outgoing Calls")),

    wk({ "<leader>gb", "<cmd>FzfLua git_bcommits<CR>" }, desc("Buffer's commit")),
    wk({ "<leader>gc", "<cmd>FzfLua git_commits<CR>" }, desc("Commit")),
    wk({ "<leader>gf", "<cmd>FzfLua git_files<CR>" }, desc("Git file")),
    wk({ "<leader>gt", "<cmd>FzfLua git_tags<CR>" }, desc("Git tag")),
}

M.config = function()
    local actions = require("fzf-lua.actions")
    require("fzf-lua").setup({
        "telescope",
        winopts = {
            preview = {
                default = (vim.fn.executable("batcat") or vim.fn.executable("cat")) and "bat" or "builtin",
                -- default = "builtin",
                layout = "flex",
            },
        },
        previewers = {
            bat = {
                cmd = vim.fn.executable("batcat") == 1 and "batcat" or "bat",
                args = "--color=always --style=numbers,changes",
                -- uncomment to set a bat theme, `bat --list-themes`
                theme = "OneHalfDark",
            },
        },
        files = {
            prompt = "Files❯ ",
            multiprocess = true, -- run command in a separate process
            git_icons = false, -- show git icons?
            file_icons = false, -- show file icons?
            color_icons = true, -- colorize file|git icons
            -- path_shorten = 1, -- 'true' or number, shorten path?
            -- executed command priority is 'cmd' (if exists)
            -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
            -- default options are controlled by 'fd|rg|find|_opts'
            -- NOTE: 'find -printf' requires GNU find
            -- cmd            = "find . -type f -printf '%P\n'",
            find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
            rg_opts = "--color=never --files --hidden --follow -g '!.git'",
            fd_opts = "--color=never --type f --hidden --follow --exclude .git",
            -- by default, cwd appears in the header only if {opts} contain a cwd
            -- parameter to a different folder than the current working directory
            -- uncomment if you wish to force display of the cwd as part of the
            -- query prompt string (fzf.vim style), header line or both
            -- cwd_header = true,
            cwd_prompt = false,
            cwd_prompt_shorten_len = 32, -- shorten prompt beyond this length
            cwd_prompt_shorten_val = 1, -- shortened path parts length
            toggle_ignore_flag = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
            actions = {
                -- inherits from 'actions.files', here we can override
                -- or set bind to 'false' to disable a default action
                --   ["default"]   = actions.file_edit,
                -- custom actions are available too
                --   ["ctrl-y"]    = function(selected) print(selected[1]) end,
                -- action to toggle `--no-ignore`, requires fd or rg installed
                --   ["ctrl-g"]    = { actions.toggle_ignore },
                ["ctrl-x"] = false,
                ["ctrl-s"] = actions.file_split,
            },
        },
        grep = {
            prompt = "Rg❯ ",
            input_prompt = "Grep For❯ ",
            multiprocess = true, -- run command in a separate process
            git_icons = true, -- show git icons?
            file_icons = true, -- show file icons?
            color_icons = true, -- colorize file|git icons
            -- executed command priority is 'cmd' (if exists)
            -- otherwise auto-detect prioritizes `rg` over `grep`
            -- default options are controlled by 'rg|grep_opts'
            -- cmd            = "rg --vimgrep",
            grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
            -- set to 'true' to always parse globs in both 'grep' and 'live_grep'
            -- search strings will be split using the 'glob_separator' and translated
            -- to '--iglob=' arguments, requires 'rg'
            -- can still be used when 'false' by calling 'live_grep_glob' directly
            rg_glob = true, -- default to glob parsing?
            glob_flag = "--iglob", -- for case sensitive globs use '--glob'
            glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
            -- advanced usage: for custom argument parsing define
            -- 'rg_glob_fn' to return a pair:
            --   first returned argument is the new search query
            --   second returned argument are addtional rg flags
            -- rg_glob_fn = function(query, opts)
            --   ...
            --   return new_query, flags
            -- end,
            actions = {
                -- actions inherit from 'actions.files' and merge
                -- this action toggles between 'grep' and 'live_grep'
                ["ctrl-g"] = { actions.grep_lgrep },
                ["ctrl-y"] = { actions.toggle_hidden },
            },
            no_header = false, -- hide grep|cwd header?
            no_header_i = false, -- hide interactive header?
        },
    })
end

return M
