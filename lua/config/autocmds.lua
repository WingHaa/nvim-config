-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = (vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout = 100 })
	end,
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", },
-- 	{
-- 		pattern = "*.blade.php",
-- 		callback = function()
-- 			local buf = vim.api.nvim_get_current_buf()
-- 			vim.api.nvim_buf_set_option(buf, "filetype", "blade")
-- 		end
-- 	}
-- )
