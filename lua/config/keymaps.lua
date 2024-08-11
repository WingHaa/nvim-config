local map = vim.keymap
local opts = { noremap = true, silent = true }
local desc = require("lib.keymap").desc

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Pick the line below and squash it on current line while keep cursor at start
map.set("n", "J", "mzJ`z")

-- keep cursor at middle of screen when navigating
map.set("n", "<C-d>", "<C-d>zz")
map.set("n", "<C-u>", "<C-u>zz") -- Keep searches at middle of screen when you search map.set("n", "n", "nzzzv")
map.set("n", "N", "Nzzzv")

-- Indenting
map.set("v", "<", "<gv") -- Shift Indentation to Left
map.set("v", ">", ">gv") -- Shift Indentation to Right

-- Resize with arrows
map.set("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
map.set("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
map.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Quickfix nav
map.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Pane and Window Navigation
map.set("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
map.set("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
map.set("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
map.set("n", "<C-l>", "<C-w>l", opts) -- Navigate Right
map.set("n", "<M-H>", "<C-w>H", opts) -- Move Pane Left
map.set("n", "<M-J>", "<C-w>J", opts) -- Move Pane Down
map.set("n", "<M-K>", "<C-w>K", opts) -- Move Pane Up
map.set("n", "<M-L>", "<C-w>L", opts) -- Move Pane Right
map.set("t", "<C-h>", "wincmd h", opts) -- Navigate Left
map.set("t", "<C-j>", "wincmd j", opts) -- Navigate Down
map.set("t", "<C-k>", "wincmd k", opts) -- Navigate Up
map.set("t", "<C-l>", "wincmd l", opts) -- Navigate Right
map.set("n", "<leader>L", "<cmd>Lazy<cr>", opts)
map.set("n", "<leader>tc", "<cmd>tabnew<cr>", desc("Tab create"))
map.set("n", "<leader>tn", "<cmd>tabnext<cr>", desc("Next tab"))
map.set("n", "<leader>tp", "<cmd>tabprevious<cr>", desc("Previous tab"))
vim.keymap.del({ "n", "x" }, "gra", { noremap = true }) -- Remove nvim default LSP code action keymapping

local terminal = require("lib.terminal")
--Lazygit
map.set("n", "<leader>gg", function()
  terminal.open({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })
