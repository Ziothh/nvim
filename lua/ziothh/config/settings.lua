-- [[ Setting options ]]
-- See `:help vim.o`

-- Make line numbers default
vim.wo.number = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Tab conficuration
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indenting
vim.opt.smartindent = true
--- Enable break indent
vim.o.breakindent = true

-- Wrapping
vim.opt.wrap = false

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Searching
vim.opt.incsearch = true
--- Set highlight on search
vim.o.hlsearch = false
--- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50 -- kickstart: 250
vim.wo.signcolumn = 'yes'

-- Screen splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Shit I don't know what it does :)
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
-- vim.opt.colorcolumn = "80" -- TODO: activate