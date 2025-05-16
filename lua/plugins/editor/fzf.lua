local desc = require("lib.keymap").desc
local wk = require("lib.keymap").wk_desc
local picker = require("lib.fzf.picker")
local M = {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    dependencies = "folke/snacks.nvim",
}

M.keys = {
    wk({ "<leader>fC", "<cmd>FzfLua commands<cr>", mode = { "n", "x" } }, desc("Commands")),
    wk({ "<leader>fF", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') })<cr>" }, desc("cwd files")),
    wk({ "<leader>fG", "<cmd>FzfLua grep<cr>" }, desc("Grep pattern")),
    wk({ "<leader>fR", "<cmd>FzfLua registers<cr>" }, desc("Registers")),
    wk({ "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>" }, desc("WORD at cursor")),
    wk({ "<leader>fb", "<cmd>FzfLua buffers<cr>" }, desc("Buffers")),
    wk({ "<leader>fc", "<cmd>FzfLua command_history<cR>", mode = { "n", "x" } }, desc("Command History")),
    wk({ "<leader>ff", "<cmd>FzfLua files<cr>", "n" }, desc("Files")),
    wk({ "<leader>fg", "<cmd>FzfLua live_grep<cr>" }, desc("Live grep")),
    wk({ "<leader>fl", "<cmd>FzfLua loclist_stack<cr>" }, desc("Location list")),
    wk({ "<leader>fm", "<cmd>FzfLua marks<cr>" }, desc("Marks")),
    wk({ "<leader>fo", "<cmd>FzfLua oldfiles<cr>" }, desc("Recent files")),
    wk({ "<leader>fq", "<cmd>FzfLua quickfix_stack<cr>" }, desc("Quickfix list")),
    wk({ "<leader>fr", "<cmd>FzfLua resume<cr>" }, desc("Resume")),
    wk({ "<leader>fw", "<cmd>FzfLua grep_cword<cr>" }, desc("word at cursor")),
    wk({ "<leader>fw", "<cmd>FzfLua grep_visual<cr>", mode = "v" }, desc("visual word")),

    wk({ "<leader>sb", picker.cword_buffer, mode = { "n", "x", "v" } }, { desc = "Buffer visual word" }),
    wk({ "<leader>sc", "<cmd>FzfLua colorschemes<cr>" }, desc("Colorscheme")),
    wk({ "<leader>sd", picker.grep_definition, mode = { "n", "x", "v" } }, { desc = "Grep Definitions" }),
    wk({ "<leader>sf", picker.cword_file }, { desc = "Find files matching cword" }),
    wk({ "<leader>sh", "<cmd>FzfLua help_tags<cr>" }, desc("Help tags")),
    wk({ "<leader>sk", "<cmd>FzfLua keymaps<cr>" }, desc("Keymaps")),
    wk({ "<leader>sr", "<cmd>FzfLua oldfiles<cr>" }, desc("Resume")),

    wk({ "<leader>gb", "<cmd>FzfLua git_branches<cr>" }, desc("Git Branch")),
    wk({ "<leader>gB", "<cmd>FzfLua git_bcommits<cr>" }, desc("Buffer's commit")),
    wk({ "<leader>gc", "<cmd>FzfLua git_commits<cr>" }, desc("Commit")),
    wk({ "<leader>gf", "<cmd>FzfLua git_files<cr>" }, desc("Git file")),
    wk({ "<leader>gt", "<cmd>FzfLua git_tags<cr>" }, desc("Git tag")),

    wk({ "gD", "<cmd>FzfLua lsp_declarations<cr>" }, desc("Declarations")),
    wk({ "gI", "<cmd>FzfLua lsp_implementations<cr>" }, desc("Implementations")),
    wk({ "gd", "<cmd>FzfLua lsp_definitions<cr>" }, desc("Definitions")),
    wk({ "gT", "<cmd>FzfLua lsp_references<cr>" }, desc("References")),
    wk({ "gt", "<cmd>FzfLua lsp_typedefs<cr>" }, desc("Type definition")),
    wk({ "<leader>lD", "<cmd>FzfLua diagnostics_workspace<cr>" }, desc("Workspace Diagnostic")),
    wk({ "<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>" }, desc("Live Symbols")),
    wk({ "<leader>ld", "<cmd>FzfLua diagnostics_document<cr>" }, desc("Document Diagnostic")),
    wk({ "<leader>li", "<cmd>FzfLua lsp_incoming_calls<cr>" }, desc("Incoming Calls")),
    wk({ "<leader>lo", "<cmd>FzfLua lsp_outgoing_calls<cr>" }, desc("Outgoing Calls")),
    wk({ "<leader>ls", "<cmd>FzfLua lsp_workspace_symbols<cr>" }, desc("Symbols")),
}

M.ui_select = function(fzf_opts, items)
    return vim.tbl_deep_extend("force", {
        prompt = " ",
        winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
        },
    }, fzf_opts.kind == "codeaction" and {
        winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = {
                layout = "vertical",
                vertical = "down:15,border-top",
            },
        },
    } or {
        winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
        },
    })
end

M.init = function()
    vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        local Plugin = require("lazy.core.plugin")
        local opts = Plugin.values("fzf-lua", "opts", false) or {}
        require("fzf-lua").register_ui_select(opts.ui_select or nil)
        return vim.ui.select(...)
    end
end

M.config = function()
    local actions = require("fzf-lua.actions")
    local fzflua = require("fzf-lua")
    local layouts = require("lib.fzf")
    local layout = layouts.ivy

    fzflua.setup({
        fzf_opts = { ["--layout"] = "default", ["--marker"] = "+" },
        winopts = {
            title_pos = "center",
            preview = {
                title_pos = "center",
                scrollbar = false,
            },
        },
        previewers = {
            builtin = {
                syntax_limit_b = 1024 * 100, -- 100KB,
            },
            bat = {
                cmd = vim.fn.executable("batcat") == 1 and "batcat" or "bat",
                args = "--color=always --style=numbers,changes",
                -- uncomment to set a bat theme, `bat --list-themes`
                theme = "OneHalfLight",
            },
        },
        lsp = {
            jump1 = true,
            ignore_current_line = true,
            jump1_action = actions.file_edit,
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
        buffers = vim.tbl_deep_extend("force", layout.buffers, {
            keymap = { builtin = { ["<C-d>"] = false } },
            actions = { ["ctrl-x"] = false, ["ctrl-d"] = { actions.buf_del, actions.resume } },
            winopts = {
                title_pos = "center",
                preview = {
                    title_pos = "center",
                    scrollbar = false,
                },
            },
            previewer = { toggle_behavior = "extend" },
        }),
        blines = layout.blines,
        lines = layout.lines,
        files = vim.tbl_deep_extend("force", layout.files, {
            cwd_prompt = false,
            winopts = {
                title_pos = "center",
                preview = {
                    title_pos = "center",
                    scrollbar = false,
                },
            },
            previewer = { toggle_behavior = "extend" },
        }),
        grep = vim.tbl_deep_extend("force", layout.grep, {
            rg_glob = true, -- default to glob parsing?
            glob_flag = "--iglob", -- for case sensitive globs use '--glob'
            glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
        }),
        grep_curbuf = layout.grep_curbuf,
        git = layout.git,
        oldfiles = {
            include_current_session = true,
        },
        marks = {
            marks = "%a",
        },
    })
end

return M
