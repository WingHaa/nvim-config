local map = vim.keymap
local desc = require("util.keymap").desc

map.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", desc("Files by name"))
map.set("n", "<leader>fg", "<cmd>FzfLua grep_project<CR>", desc("Grep pattern"))
map.set("n", "<leader>fG", "<cmd>FzfLua live_grep_glob<CR>", desc("Live grep glob"))
map.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc("Recent files"))
map.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", desc("Buffers"))
map.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc("Keymaps"))
map.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc("word at cursor"))
map.set("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<CR>", desc("WORD at cursor"))
map.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", desc("Resume"))

return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({
			"telescope",
			winopts = { preview = { default = "bat" } },
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
				builtin = {
					-- previewer treesitter options:
					-- enable specific filetypes with: `{ enable = { "lua" } }
					-- exclude specific filetypes with: `{ disable = { "lua" } }
					-- disable fully with: `{ enable = false }`
					treesitter = { enable = true, disable = {} },
					extensions = {
						-- neovim terminal only supports `viu` block output
						["png"] = { "chafa", "{file}" },
						-- by default the filename is added as last argument
						-- if required, use `{file}` for argument positioning
						["svg"] = { "chafa", "{file}" },
						["jpg"] = { "chafa", "{file}" },
					},
					-- if using `ueberzug` in the above extensions map
					-- set the default image scaler, possible scalers:
					--   false (none), "crop", "distort", "fit_contain",
					--   "contain", "forced_cover", "cover"
					-- https://github.com/seebye/ueberzug
					ueberzug_scaler = "cover",
					-- Custom filetype autocmds aren't triggered on
					-- the preview buffer, define them here instead
					-- ext_ft_override = { ["ksql"] = "sql", ... },
				},
			},
			files = {
				prompt = "Files❯ ",
				find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
				rg_opts = "--color=never --files --hidden --follow -g '!.git'",
				fd_opts = "--color=never --type f --hidden --follow --exclude .git",
			},
		})
	end,
}
