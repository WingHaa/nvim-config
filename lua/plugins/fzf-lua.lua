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
map.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", desc("Marks"))
map.set("n", "<leader>fq", "<cmd>FzfLua quickfix<CR>", desc("Quickfix list"))
map.set("n", "<leader>fl", "<cmd>FzfLua loclist<CR>", desc("Location list"))
map.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", desc("Resume"))
map.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc("Help tags"))
map.set("n", "<leader>fm", "<cmd>FzfLua man_pages<CR>", desc("Man pages"))

return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
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
				prompt = "Files❯ ",
				find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
				rg_opts = "--color=never --files --hidden --follow -g '!.git'",
				fd_opts = "--color=never --type f --hidden --follow --exclude .git",
			},
		})
	end,
}
