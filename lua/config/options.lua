local opt = vim.opt
--Behavior
opt.shell = "/bin/sh"
opt.clipboard = "unnamedplus"
opt.backup = false
opt.swapfile = false
--opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.cursorline = false
opt.hidden = true
opt.updatetime = 50
opt.ttyfast = true
opt.autochdir = false
opt.splitright = true
opt.splitbelow = true

-- Tab & Indent
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false

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
vim.wo.signcolumn = "yes:1"

vim.g.autoformat = false

vim.o.guicursor =
"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,n:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
