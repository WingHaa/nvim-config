local desc = require("util.keymap").desc
local M = {
  "ibhagwan/fzf-lua",
  cmd = { "FzfLua" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.keys = {
  { "<leader>ff", "<cmd>FzfLua files<CR>", "n", desc("Find files") },
  {
    "<leader>fF",
    "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') })<CR>",
    "n",
    desc("Find files"),
  },
  { "<leader>fg", "<cmd>FzfLua grep_project<CR>", "n", desc("Grep pattern") },
  { "<leader>fG", "<cmd>FzfLua live_grep_glob<CR>", "n", desc("Live grep glob") },
  { "<leader>fo", "<cmd>FzfLua oldfiles<CR>", "n", desc("Recent files") },
  { "<leader>fb", "<cmd>FzfLua buffers<CR>", "n", desc("Buffers") },
  { "<leader>fk", "<cmd>FzfLua keymaps<CR>", "n", desc("Keymaps") },
  { "<leader>fw", "<cmd>FzfLua grep_cword<CR>", "n", desc("word at cursor") },
  { "<leader>fW", "<cmd>FzfLua grep_cWORD<CR>", "n", desc("WORD at cursor") },
  { "<leader>fm", "<cmd>FzfLua marks<CR>", "n", desc("Marks") },
  { "<leader>fq", "<cmd>FzfLua quickfix<CR>", "n", desc("Quickfix list") },
  { "<leader>fl", "<cmd>FzfLua loclist<CR>", "n", desc("Location list") },
  { "<leader>fr", "<cmd>FzfLua resume<CR>", "n", desc("Resume") },
  { "<leader>fh", "<cmd>FzfLua help_tags<CR>", "n", desc("Help tags") },
  { "<leader>fc", "<cmd>FzfLua colorschemes<CR>", "n", desc("Colorscheme") },
  { "<leader>sc", "<cmd>FzfLua commands<CR>", "n", desc("Commands") },
  { "<leader>sh", "<cmd>FzfLua command_history<CR>", "n", desc("Command History") },
  { "<leader>gc", "<cmd>FzfLua git_bcommits<CR>", "n", desc("Git branch's commit") },
  { "<leader>gb", "<cmd>FzfLua git_branches<CR>", "n", desc("Git branch") },
  { "<leader>gs", "<cmd>FzfLua git_stash<CR>", "n", desc("Git stash") },
  { "<leader>gf", "<cmd>FzfLua git_files<CR>", "n", desc("Git file") },
  { "<leader>gt", "<cmd>FzfLua git_tags<CR>", "n", desc("Git tag") },
}

M.config = function()
  local actions = require("fzf-lua.actions")
  require("fzf-lua").setup({
    "telescope",
    winopts = {
      preview = {
        default = (vim.fn.executable("batcat") or vim.fn.executable("cat")) and "bat" or "builtin",
        layout = "vertical",
      },
    },
    fzf_opts = {
      ["--layout"] = "reverse",
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
      git_icons = true, -- show git icons?
      file_icons = true, -- show file icons?
      color_icons = true, -- colorize file|git icons
      -- path_shorten   = 1,              -- 'true' or number, shorten path?
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
      cwd_prompt = true,
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
      },
      no_header = false, -- hide grep|cwd header?
      no_header_i = false, -- hide interactive header?
    },
  })
end

return M
