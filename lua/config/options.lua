local o = vim.opt
--Behavior
o.shell = "/bin/sh"
-- opt.clipboard = "unnamedplus"
o.backup = false
o.swapfile = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.cursorline = false
o.hidden = true
o.updatetime = 50
o.ttyfast = true
o.autochdir = false
o.splitright = true
o.splitbelow = true

-- Tab & Indent
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.smartindent = true
o.wrap = false
o.expandtab = true

-- Disable mouse
o.mouse = ""

-- Search
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = true

--Appearance
o.number = true
o.relativenumber = true
o.termguicolors = true
o.scrolloff = 8
o.list = false
o.listchars = {
    -- eol = "↲",
    trail = "·",
    conceal = "┊",
    nbsp = "☠",
    tab = " »",
}

o.foldlevel = 99
vim.go.foldcolumn = "auto"

vim.wo.signcolumn = "yes:1"

vim.g.autoformat = false

o.spell = false
o.spelllang = "en_us"
o.spelloptions = "camel"
o.spellcapcheck = ""

o.diffopt = {
    "internal",
    "filler",
    "closeoff",
    "context:12",
    "algorithm:histogram",
    "linematch:40",
    "inline:char",
}
