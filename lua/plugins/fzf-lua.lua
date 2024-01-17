local map = vim.keymap
local desc = require("util.keymap").desc

map.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", desc("Find files"))
map.set("n", "<leader>fg", "<cmd>FzfLua grep_project<CR>", desc("Grep pattern"))
map.set("n", "<leader>fG", "<cmd>FzfLua live_grep_glob<CR>", desc("Live grep glob"))
map.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc("Recent files"))
map.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", desc("Buffers"))
map.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc("Keymaps"))
map.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc("word at cursor"))
map.set("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<CR>", desc("WORD at cursor"))
map.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", desc("Marks"))
map.set("n", "<leader>fq", "<cmd>FzfLua quickfix<CR>", desc("Quickfix list"))
map.set("n", "<leader>fl", "<cmd>FzfLua loclist<CR>", desc("Location list"))
map.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", desc("Resume"))
map.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc("Help tags"))
map.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<CR>", desc("Colorscheme"))
map.set("n", "<leader>sc", "<cmd>FzfLua commands<CR>", desc("Commands"))
map.set("n", "<leader>sh", "<cmd>FzfLua command_history<CR>", desc("Command History"))
map.set("n", "<leader>gc", "<cmd>FzfLua git_bcommits<CR>", desc("Git branch's commit"))
map.set("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", desc("Git branch"))
map.set("n", "<leader>gs", "<cmd>FzfLua git_stash<CR>", desc("Git stash"))
map.set("n", "<leader>gf", "<cmd>FzfLua git_files<CR>", desc("Git file"))
map.set("n", "<leader>gt", "<cmd>FzfLua git_tags<CR>", desc("Git tag"))

return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local actions = require("fzf-lua.actions")
		require("fzf-lua").setup({
			"telescope",
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
				-- previewer      = "bat",          -- uncomment to override previewer
				-- (name from 'previewers' table)
				-- set to 'false' to disable
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
				rg_glob = false, -- default to glob parsing?
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
	end,
}
