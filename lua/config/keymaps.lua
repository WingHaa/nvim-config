local map = vim.keymap
local opts = { noremap = true, silent = true }
local desc = require("util.keymap").desc

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
map.set("t", "<C-H>", "wincmd h", opts) -- Navigate Left
map.set("t", "<C-j>", "wincmd j", opts) -- Navigate Down
map.set("t", "<C-k>", "wincmd k", opts) -- Navigate Up
map.set("t", "<C-l>", "wincmd l", opts) -- Navigate Right
map.set("n", "<leader>L", "<cmd>Lazy<cr>", opts)

-- dd only yank if line not empty
map.set("n", "dd", function()
  ---@diagnostic disable-next-line: param-type-mismatch
  if vim.fn.getline("."):match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- -- clipboard
-- vim.keymap.set("n", "<leader>y", '"+y', desc("Yank to clipboard"))
-- vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', desc("Yank to clipboard"))
-- vim.keymap.set("n", "<leader>yy", '"+yy', desc("Yank line to clipboard"))
-- vim.keymap.set("n", "<leader>Y", '"+y$', desc("Yank till eol to clipboard"))
-- vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', desc("Paste from clipboard"))
-- vim.keymap.set("x", "<leader>P", '"_dP', desc("Paste over selection without erasing unnamed register"))

local terminal = require("util.terminal")
--Lazygit
map.set("n", "<leader>gg", function()
  terminal.open({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })
