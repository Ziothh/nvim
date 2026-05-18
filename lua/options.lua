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

-- Default border for floating windows (hover, signature help, etc.).
-- Replaces v2.0 NvChad's vim.lsp.with(... { border = "rounded" }) which is
-- gone in v2.5 / removed in Nvim 0.12.
o.winborder = "rounded"
