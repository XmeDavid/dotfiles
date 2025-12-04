local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true
opt.wrap = false

-- Clipboard
opt.clipboard = "unnamedplus"

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files and undo
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.cursorline = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
