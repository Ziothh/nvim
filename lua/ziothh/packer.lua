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

  -- General packages that are required by other packages
  use "nvim-lua/plenary.nvim"

  -- Additional lua configuration, makes nvim stuff amazing
  use 'folke/neodev.nvim'

  -- use {
  --     'VonHeikemen/lsp-zero.nvim',
  --     requires = {
  --         -- LSP Support
  --         { 'neovim/nvim-lspconfig' },
  --         --- Automatically install LSPs to stdpath for neovim
  --         { 'williamboman/mason.nvim' },
  --         { 'williamboman/mason-lspconfig.nvim' },

  --         -- Autocompletion
  --         { 'hrsh7th/nvim-cmp' },
  --         { 'hrsh7th/cmp-buffer' },
  --         { 'hrsh7th/cmp-path' },
  --         { 'saadparwaiz1/cmp_luasnip' },
  --         { 'hrsh7th/cmp-nvim-lsp' },
  --         { 'hrsh7th/cmp-nvim-lua' },

  --

  --         -- Snippets
  --         { 'L3MON4D3/LuaSnip' },
  --         { 'rafamadriz/friendly-snippets' },

  --     }
  -- }

  -- [[ LSP Configuration & Plugins ]]
  -- This comes from the kickstart
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- 'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- Rust LSP stuff
  use {
    'simrat39/rust-tools.nvim',
    requires = {
      "neovim/nvim-lspconfig"
    }
  }

  --   use { -- Autocompletion
  --     'hrsh7th/nvim-cmp',
  --     requires = {
  --         'hrsh7th/cmp-nvim-lsp',
  --         'L3MON4D3/LuaSnip',
  --         'saadparwaiz1/cmp_luasnip'
  --     },
  --   }

  -- Useful status updates for LSP
  use { 'j-hui/fidget.nvim' }

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
  --     use {
  --     "lunarvim/onedarker.nvim",
  --     -- branch = "freeze",
  --     -- config = function()
  --     --   pcall(function()
  --     --     if lvim and lvim.colorscheme == "onedarker" then
  --     --       require("onedarker").setup()
  --     --       lvim.builtin.lualine.options.theme = "onedarker"
  --     --     end
  --     --   end)
  --     -- end,
  --     -- disable = lvim.colorscheme ~= "onedarker",
  --   }

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
  use { 'lukas-reineke/indent-blankline.nvim', disable = true } -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  -- use("windwp/nvim-autopairs")
  -- use("windwp/nvim-ts-autotag")
  -- Zen mode
  use("folke/zen-mode.nvim") -- :ZenMode


  -- Some plugins to consider
  -- use("christoomey/vim-tmx-navigator")
  -- use("szw/vim-maximizer") -- maximises and restores current window


  -- [[ Lunarvim packages ]]
  -- { "neovim/nvim-lspconfig" },
  use("tamago324/nlsp-settings.nvim")
  use "jose-elias-alvarez/null-ls.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use {
    "williamboman/mason.nvim",
    --   config = function()
    --     require("lvim.core.mason").setup() -- TODO
    --   end,
  }

  -- Themes
  use "folke/tokyonight.nvim"
  use "lunarvim/lunar.nvim"

  -- Utils
  use "Tastyep/structlog.nvim"
  use "nvim-lua/popup.nvim"

  -- Telescope
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   branch = "0.1.x",
  --   config = function()
  --     require("lvim.core.telescope").setup()
  --   end,
  --   disable = not lvim.builtin.telescope.active,
  -- },
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   requires = { "nvim-telescope/telescope.nvim" },
  --   run = "make",
  --   disable = not lvim.builtin.telescope.active,
  -- },
  -- Install nvim-cmp, and buffer source as a dependency
  use {
    "hrsh7th/nvim-cmp",
    --   config = function()
    --     if lvim.builtin.cmp then
    --       require("lvim.core.cmp").setup()
    --     end
    --   end,
    requires = {
      "L3MON4D3/LuaSnip",
    },
  }

  use {
    "rafamadriz/friendly-snippets",
  }

  use {
    "L3MON4D3/LuaSnip",
    --   config = function()
    --     local utils = require "lvim.utils"
    --     local paths = {}
    --     if lvim.builtin.luasnip.sources.friendly_snippets then
    --       paths[#paths + 1] = utils.join_paths(get_runtime_dir(), "site", "pack", "packer", "start", "friendly-snippets")
    --     end
    --     local user_snippets = utils.join_paths(get_config_dir(), "snippets")
    --     if utils.is_directory(user_snippets) then
    --       paths[#paths + 1] = user_snippets
    --     end
    --     require("luasnip.loaders.from_lua").lazy_load()
    --     require("luasnip.loaders.from_vscode").lazy_load {
    --       paths = paths,
    --     }
    --     require("luasnip.loaders.from_snipmate").lazy_load()
    --   end,
  }
  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'

  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  -- use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'

  use {
    "saadparwaiz1/cmp_luasnip",
  }

  -- {
  --   "folke/neodev.nvim",
  --   module = "neodev",
  -- },

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    --   config = function()
    --     require("lvim.core.autopairs").setup()
    --   end,
    --   disable = not lvim.builtin.autopairs.active,
  }

  -- Treesitter
  -- use {
  --   "nvim-treesitter/nvim-treesitter",
  --   -- run = ":TSUpdate",
  -- --   config = function()
  -- --     require("lvim.core.treesitter").setup()
  -- --   end,
  -- },
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  }

  -- NvimTree
  -- use {
  --   "kyazdani42/nvim-tree.lua",
  -- event = "BufWinOpen",
  -- cmd = "NvimTreeToggle",
  --   config = function()
  --     require("lvim.core.nvimtree").setup()
  --   end,
  --   disable = not lvim.builtin.nvimtree.active,
  -- }
  -- Simple file explorer
  -- use {
  --   "christianchiarulli/lir.nvim",
  -- --   config = function()
  -- --     require("lvim.core.lir").setup()
  -- --   end,
  --   requires = { "kyazdani42/nvim-web-devicons" },
  -- --   disable = not lvim.builtin.lir.active,
  -- }
  -- {
  --   "lewis6991/gitsigns.nvim",

  --   config = function()
  --     require("lvim.core.gitsigns").setup()
  --   end,
  --   event = "BufRead",
  --   disable = not lvim.builtin.gitsigns.active,
  -- },

  -- ! Whichkey (shows a popup with possible key bindings)
  use {
    "folke/which-key.nvim",
    --   config = function()
    --     require("lvim.core.which-key").setup()
    --   end,
    event = "BufWinEnter",
    --   disable = not lvim.builtin.which_key.active,
  }

  -- Comments
  -- {
  --   "numToStr/Comment.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lvim.core.comment").setup()
  --   end,
  --   disable = not lvim.builtin.comment.active,
  -- },

  -- project.nvim -- TODO: later
  -- {
  --   "ahmedkhalf/project.nvim",
  -- --   config = function()
  -- --     require("lvim.core.project").setup()
  -- --   end,
  -- --   disable = not lvim.builtin.project.active,
  -- }

  -- Icons
  use {
    "kyazdani42/nvim-web-devicons",
    --   disable = not lvim.use_icons,
  }

  -- Status Line and Bufferline
  -- {
  --   -- "hoob3rt/lualine.nvim",
  --   "nvim-lualine/lualine.nvim",
  --   -- "Lunarvim/lualine.nvim",
  --   config = function()
  --     require("lvim.core.lualine").setup()
  --   end,
  --   disable = not lvim.builtin.lualine.active,
  -- },

  -- breadcrumbs
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
    --   config = function()
    --     require("lvim.core.breadcrumbs").setup()
    --   end,
    --   disable = not lvim.builtin.breadcrumbs.active,
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    event = "BufWinEnter",
    -- config = function()
    --     require("lvim.core.bufferline").setup()
    --   end,
    --   branch = "main",
    --   event = "BufWinEnter",
    --   disable = not lvim.builtin.bufferline.active,
  }

  -- [[ Debugging ]] -- TODO: later
  -- use {
  --   "mfussenegger/nvim-dap",
  --   -- event = "BufWinEnter",
  -- --   config = function()
  -- --     require("lvim.core.dap").setup()
  -- --   end,
  -- --   disable = not lvim.builtin.dap.active,
  -- }

  -- -- Debugger user interface
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   config = function()
  --     require("lvim.core.dap").setup_ui()
  --   end,
  --   disable = not lvim.builtin.dap.active,
  -- },

  -- alpha (greeter when executing plain "vim" in shell)
  use {
    "goolord/alpha-nvim",
    --   config = function()
    --     require("lvim.core.alpha").setup()
    --   end,
    --   disable = not lvim.builtin.alpha.active,
  }

  -- [[ Terminal ]]
  -- Enables opening terminal windows in vim
  use {
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    branch = "main",
    --   config = function()
    --     require("lvim.core.terminal").setup()
    --   end,
    --   disable = not lvim.builtin.terminal.active,
  }

  -- SchemaStore (access to JSON schemas) -- ?
  use {
    "b0o/schemastore.nvim",
  }

  -- VSCode-like highlighting of all occurences of the current word
  -- use {
  --   "RRethy/vim-illuminate",
  --   config = function()
  --     require("lvim.core.illuminate").setup()
  --   end,
  --   disable = not lvim.builtin.illuminate.active,
  -- },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = function()
  --     require("lvim.core.indentlines").setup()
  --   end,
  --   disable = not lvim.builtin.indentlines.active,
  -- },



  use {
    "lunarvim/bigfile.nvim",
    --   config = function()
    --     pcall(function()
    --       require("bigfile").config(lvim.builtin.bigfile.config)
    --     end)
    --   end,
    --   disable = not lvim.builtin.bigfile.active,
  }

  use 'voldikss/vim-floaterm'


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
