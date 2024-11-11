local opt = vim.opt
--Behavior
opt.shell = "/bin/sh"
-- opt.clipboard = "unnamedplus"
opt.backup = false
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.cursorline = false
opt.hidden = true
opt.updatetime = 50
opt.ttyfast = true
opt.autochdir = false
opt.splitright = true
opt.splitbelow = true

-- Tab & Indent
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.wrap = false
opt.expandtab = true

-- Disable mouse
opt.mouse = ""

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

--Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.scrolloff = 8

opt.foldlevel = 99
vim.go.foldcolumn = "auto"

vim.wo.signcolumn = "yes:1"

vim.g.autoformat = false

opt.spell = true
opt.spelllang = "en_us"
opt.spelloptions = "camel"
opt.spellcapcheck = ""
