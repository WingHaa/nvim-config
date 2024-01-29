-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = (vim.fn["hlexists"]("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "IncSearch"),
			timeout = 100,
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		local file_name = vim.fn.expand("%:t")
		if string.match(file_name, "compose%.yml$") or string.match(file_name, "compose%.yaml$") then
			vim.bo.filetype = "yaml.docker-compose"
		end
	end,
})

-- Dadbod completion
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
		vim.b.ignore_early_retirement = true
	end,
})
