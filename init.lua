require "custom.configs.diagnostics"
require "custom.configs.prettier"
require "custom.configs.treesitter"
-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Make line numbers default
vim.wo.number = true -- set numbered lines
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indenting
vim.opt.smartindent = true
--- Enable break indent
vim.o.breakindent = true

vim.wo.wrap = false

-- Tab conficuration
local tab_size = 4
vim.opt.tabstop = tab_size
vim.opt.softtabstop = tab_size -- insert #tab_size spaces for a tab
vim.opt.shiftwidth = tab_size -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false -- creates a backup file
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true -- enable persistent undo

-- Searching
vim.opt.incsearch = true
--- Set highlight on search
vim.o.hlsearch = false -- highlight all matches on previous search pattern
--- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.smartcase = true -- smart case

-- Decrease update time
vim.o.updatetime = 50 -- faster completion
vim.wo.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Shit I don't know what it does :)
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
vim.opt.isfname:append "@-@"
-- vim.opt.colorcolumn = "80" -- TODO: activate

-- [ Auto  commands ]
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})
