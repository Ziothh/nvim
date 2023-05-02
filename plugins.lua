local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.configs.null-ls").setup()
        end,
      },
    },
    lazy = false,
    config = function()
      local config = require "plugins.configs.lspconfig"
      require("custom.configs.lspconfig").setup(config.on_attach, config.capabilities)
    end, -- Override to setup mason-lspconfig
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "rust",
        "toml",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = false,
        additional_vim_regex_highlighting = false,
        -- disable = {
        --   "python"
        -- },
      },
    },
    -- config = function(_, opts)
    --   require("nvim-treesitter.configs").setup(opts)
    --
    --   local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --   parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    -- end,
    lazy = false,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        timeout = 100,
      }
    end,
  },

  -- To make a plugin not be loaded
  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    config = function(_, opts)
      require("colorizer").setup {
        filetypes = {
          "css",
          "javascript",
          "html",
        },
        user_default_options = { mode = "virtualtext" },
      }
      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = function()
      local wilder = require "wilder"
      wilder.setup {
        modes = { ":", "/", "?" },
        next_key = "<C-n>",
        previous_key = "<C-p>",
        accept_key = "<Tab>",
        reject_key = "<S-Tab>",
      }

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
          highlighter = wilder.basic_highlighter(),
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
          accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
          -- separator = " · ",
          -- left = { " ", wilder.wildmenu_spinner(), " " }, -- Show spinner
          -- right = { " ", wilder.wildmenu_index() }, -- Show number of items
          highlights = {
            border = "Normal", -- highlight to use for the border
          },
          -- pumblend = 20, -- Opacity
          -- 'single', 'double', 'rounded' or 'solid'
          -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
          border = "rounded",
        })
      )
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    -- event = ""
    -- init = function()
    --   require("core.utils").lazy_load "indent-blankline.nvim"
    -- end,
    -- opts = function()
    --   return require("plugins.configs.others").blankline
    -- end,
    -- config = function(_, opts)
    --   require("core.utils").load_mappings "blankline"
    --   dofile(vim.g.base46_cache .. "blankline")
    --   require("indent_blankline").setup(opts)
    -- end,
  },

  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  },

  {
    "simrat39/rust-tools.nvim",
    event = "BufEnter",
    -- init = function()
    --   require("core.utils").lazy_load "nvim-lspconfig"
    -- end,
    --   -- event = "BufEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("custom.configs.rust-tools").setup()
    end, -- Override to setup mason-lspconfig
  },

  {
    "theprimeagen/harpoon",
    config = function(_, opts)
      require("custom.configs.harpoon").setup()
    end,
    event = "VeryLazy",
  },
}

return plugins
