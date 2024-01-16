local map = vim.keymap
local desc = require("util.keymap").desc

return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({
			"telescope",
			winopts = { preview = { default = "bat" } },
			previewers = {
				bat = {
					cmd = "bat",
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
		})

		map.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc("Files by name"))
		map.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').grep()<CR>", desc("Grep pattern"))
		map.set("n", "<leader>fG", "<cmd>lua require('fzf-lua').live_grep_glob()<CR>", desc("Live grep glob"))
		map.set("n", "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", desc("Recent files"))
		map.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", desc("Buffers"))
		map.set("n", "<leader>fk", "<cmd>lua require('fzf-lua').keymaps()<CR>", desc("Keymaps"))
		map.set("n", "<leader>fw", "<cmd>lua require('fzf-lua').grep_cword()<CR>", desc("word at cursor"))
		map.set("n", "<leader>fW", "<cmd>lua require('fzf-lua').grep_cWORD()<CR>", desc("WORD at cursor"))
		map.set("n", "<leader>fr", "<cmd>lua require('fzf-lua').resume()<CR>", desc("Resume"))

		map.set({ "n", "v" }, "<leader>ca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc("Code Actions"))
		map.set("n", "<leader>fo", "<cmd>lua require('fzf-lua').lsp_references()<CR>", desc("References"))
		map.set("n", "<leader>fd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", desc("Definitions"))
		map.set("n", "<leader>ft", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", desc("Type definition"))
		map.set("n", "<leader>fi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", desc("Implementations"))
	end,
}
