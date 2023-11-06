-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=200}
augroup END
]])

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		if vim.fn.argv(0) == "" then
-- 			require("telescope.builtin").find_files()
-- 		end
-- 	end,
-- })
