local map = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Pick the line below and squash it on current line while keep cursor at start
map.set("n", "J", "mzJ`z")
-- keep cursor at middle of screen when navigating
map.set("n", "<C-d>", "<C-d>zz")
map.set("n", "<C-u>", "<C-u>zz")
-- Keep searches at middle of screen when you search
map.set("n", "n", "nzzzv")
map.set("n", "N", "Nzzzv")

-- Indenting
map.set("v", "<", "<gv") -- Shift Indentation to Left
map.set("v", ">", ">gv") -- Shift Indentation to Right

-- Resize with arrows
map.set("n", "<C-Up>", ":resize -2<CR>")
map.set("n", "<C-Down>", ":resize +2<CR>")
map.set("n", "<C-Left>", ":vertical resize -2<CR>")
map.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Pane and Window Navigation
map.set("n", "<C-h>", "<C-w>h", opts)   -- Navigate Left
map.set("n", "<C-j>", "<C-w>j", opts)   -- Navigate Down
map.set("n", "<C-k>", "<C-w>k", opts)   -- Navigate Up
map.set("n", "<C-l>", "<C-w>l", opts)   -- Navigate Right
map.set("n", "<M-H>", "<C-w>H", opts)   -- Move Pane Left
map.set("n", "<M-J>", "<C-w>J", opts)   -- Move Pane Down
map.set("n", "<M-K>", "<C-w>K", opts)   -- Move Pane Up
map.set("n", "<M-L>", "<C-w>L", opts)   -- Move Pane Right
map.set("t", "<C-H>", "wincmd h", opts) -- Navigate Left
map.set("t", "<C-j>", "wincmd j", opts) -- Navigate Down
map.set("t", "<C-k>", "wincmd k", opts) -- Navigate Up
map.set("t", "<C-l>", "wincmd l", opts) -- Navigate Right
map.set("n", "<leader>L", ":Lazy<cr>", opts)

--Cause q: is a bitch
map.set("n", "<leader>q", ":qa<cr>", opts)
