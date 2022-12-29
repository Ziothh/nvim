-- [[ Setting options ]]
-- See `:help vim.o`

-- Make line numbers default
vim.wo.number = true -- set numbered lines
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a' -- allow the mouse to be used in neovim

-- Tab conficuration
vim.opt.tabstop = 4
vim.opt.softtabstop = 4 -- insert 4 spaces for a tab
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces

-- Indenting
vim.opt.smartindent = true
--- Enable break indent
vim.o.breakindent = true

-- Wrapping
vim.opt.wrap = false -- display lines as one long line

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false -- creates a backup file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
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
vim.wo.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time

-- Screen splitting
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.splitbelow = true -- force all horizontal splits to go below current window

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Shit I don't know what it does :)
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
vim.opt.isfname:append("@-@")
-- vim.opt.colorcolumn = "80" -- TODO: activate

-- Lunarvim config stuff
local default_options = {
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    -- completeopt = { "menuone", "noselect" },
    conceallevel = 0, -- so that `` is visible in markdown files
    -- fileencoding = "utf-8", -- the encoding written to a file
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    -- guifont = "monospace:h17", -- the font used in graphical neovim applications
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    -- pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore (bar)
    showtabline = 2, -- always show tabs
    -- swapfile = false, -- creates a swapfile -- TODO: tmux
    termguicolors = true, -- set term gui colors (most terminals support this)
    -- timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- set the title of window to the value of the titlestring
    titlestring = "%<%F%=%l/%L - nvim", -- what the title of the window will be set to
    -- undodir = undodir, -- set an undo directory
    -- writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    -- cursorline = true, -- highlight the current line
    -- number = true, 
    numberwidth = 4, -- set number column width to 2 {default 4}
    -- shadafile = join_paths(get_cache_dir(), "lvim.shada"),
    sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
    showcmd = false,
    ruler = false,
    laststatus = 3,
}

for k, v in pairs(default_options) do
vim.opt[k] = v
end