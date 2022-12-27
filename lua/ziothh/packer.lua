local packer = require('packer')

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

packer.startup(function(use)
  -- Package manager (it can manage itself)
  use 'wbthomason/packer.nvim'

  -- Additional lua configuration, makes nvim stuff amazing
  use 'folke/neodev.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            --- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim' }, 

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

        }
    }

-- This comes from the kickstart
--   use { -- LSP Configuration & Plugins
--     'neovim/nvim-lspconfig',
--     requires = {
--       -- Automatically install LSPs to stdpath for neovim
--       'williamboman/mason.nvim',
--       'williamboman/mason-lspconfig.nvim',

--       -- Useful status updates for LSP
--       'j-hui/fidget.nvim',

--       -- Additional lua configuration, makes nvim stuff amazing
--       'folke/neodev.nvim',
--     },
--   }

--   use { -- Autocompletion
--     'hrsh7th/nvim-cmp',
--     requires = { 
--         'hrsh7th/cmp-nvim-lsp', 
--         'L3MON4D3/LuaSnip', 
--         'saadparwaiz1/cmp_luasnip' 
--     },
--   }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
    --   use('nvim-treesitter/playground')

    -- File management
    use('theprimeagen/harpoon') -- Harpoon
    use('mbbill/undotree') -- Undos
    use("nvim-tree/nvim-tree.lua") -- File tree


  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- Themes
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
        vim.cmd('colorscheme rose-pine')
    end
})

  -- Visual stuff
  --- Stafflines
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- OR
  -- use 'vim-airline/vim-airline' -- A lualine alternative


  -- Fuzzy finder
  --- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  --- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Quality of life things
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
   -- use("windwp/nvim-autopairs")
    -- use("windwp/nvim-ts-autotag")
  -- Zen mode
  use("folke/zen-mode.nvim") -- :ZenMode


    -- Some plugins to consider
    -- use("christoomey/vim-tmx-navigator")
    -- use("szw/vim-maximizer") -- maximises and restores current window

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    packer.sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


return packer