local map = vim.keymap

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

map.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Resize with arrows
map.set("n", "<C-Up>", ":resize -2<CR>")
map.set("n", "<C-Down>", ":resize +2<CR>")
map.set("n", "<C-Left>", ":vertical resize -2<CR>")
map.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Pane and Window Navigation
map.set("n", "<C-h>", "<C-w>h") -- Navigate Left
map.set("n", "<C-j>", "<C-w>j") -- Navigate Down
map.set("n", "<C-k>", "<C-w>k") -- Navigate Up
map.set("n", "<C-l>", "<C-w>l") -- Navigate Right
map.set("t", "<C-h>", "wincmd h") -- Navigate Left
map.set("t", "<C-j>", "wincmd j") -- Navigate Down
map.set("t", "<C-k>", "wincmd k") -- Navigate Up
map.set("t", "<C-l>", "wincmd l") -- Navigate Right
