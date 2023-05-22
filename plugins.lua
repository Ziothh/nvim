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
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function ()
      -- The setup config table shows all available config options with their default values:
      require("presence").setup({
          -- General options
          auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
          neovim_image_text   = "NeoVim dees nuts",         -- Text displayed when hovered over the Neovim image
          -- neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
          main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
          client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
          log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
          debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
          enable_line_number  = false,                      -- Displays the current line number instead of the current project
          blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
          buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
          file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
          show_time           = true,                       -- Show the timer

          -- Rich Presence text options
          editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
          file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
          git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
          plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
          reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
          workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
          line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      })
    end
  }
}

return plugins
