local map = vim.keymap
local desc = require("util.keymap").desc

return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({ "telescope" })

		map.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc("Files by name"))
		map.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').grep()<CR>", desc("Grep pattern"))
		map.set("n", "<leader>fG", "<cmd>lua require('fzf-lua').live_grep_glob()<CR>", desc("Live grep glob"))
		map.set("n", "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", desc("Recent files"))
		map.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", desc("Buffers"))
		map.set("n", "<leader>fk", "<cmd>lua require('fzf-lua').keymaps()<CR>", desc("Keymaps"))
		map.set("n", "<leader>fw", "<cmd>lua require('fzf-lua').grep_cword()<CR>", desc("word at cursor"))
		map.set("n", "<leader>fW", "<cmd>lua require('fzf-lua').grep_cWORD()<CR>", desc("WORD at cursor"))
		map.set("n", "<leader>fr", "<cmd>lua require('fzf-lua').resume()<CR>", desc("Resume"))

		map.set("n", "<leader>fc", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc("Code Actions"))
		map.set("n", "<leader>fo", "<cmd>lua require('fzf-lua').lsp_references()<CR>", desc("References"))
		map.set("n", "<leader>fd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", desc("Definitions"))
		map.set("n", "<leader>ft", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", desc("Type definition"))
		map.set("n", "<leader>fi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", desc("Implementations"))
	end,
}
