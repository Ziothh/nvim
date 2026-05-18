require "nvchad.options"

local o = vim.o
local opt = vim.opt

o.relativenumber = true
o.breakindent = true
o.wrap = false

-- Indent: 4-space tabs across the board (overrides nvchad default of 2)
local tab_size = 4
opt.tabstop = tab_size
opt.softtabstop = tab_size
opt.shiftwidth = tab_size
opt.expandtab = true

-- Persistent undo, no swap, no backup
o.swapfile = false
o.backup = false
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
o.undofile = true

o.incsearch = true
o.hlsearch = false

o.updatetime = 50
opt.scrolloff = 8
opt.isfname:append "@-@"
