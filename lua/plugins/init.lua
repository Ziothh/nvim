return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Formatting (conform): per-project prettierd/biome with ts_ls fallback
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    cmd = "ConformInfo",
    opts = function()
      return require "configs.conform"
    end,
  },

  -- Treesitter: ensure_installed extras
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css",
        "javascript", "typescript", "tsx",
        "c", "markdown", "markdown_inline",
        "rust", "toml",
      },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = false },
    },
  },

  -- Disable NvChad's indent guide lines (indent-blankline)
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    init = function()
      require "configs.rustaceanvim"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    config = function(_, opts)
      local setup = require "configs.cmp"
      setup(opts)
    end,
  },

  -- Harpoon
  {
    "theprimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local mark = require "harpoon.mark"
      local ui = require "harpoon.ui"
      local map = vim.keymap.set
      map("n", "<leader>pa", mark.add_file, { desc = "[A]dd current file to harpoon" })
      map("n", "<leader>pe", ui.toggle_quick_menu, { desc = "Open harpoon menu" })
      map("n", "<leader>pp", ui.nav_prev, { desc = "[P]revious harpoon file" })
      map("n", "<leader>pn", ui.nav_next, { desc = "[N]ext harpoon file" })
    end,
  },

  -- Git worktree
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("git-worktree").setup {}
      require("telescope").load_extension "git_worktree"
      vim.keymap.set("n", "<leader>gwt", function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end, { desc = "Manage [G]it [W]ork [T]rees" })
    end,
  },

  -- 99 (Claude integration)
  {
    "ThePrimeagen/99",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      local _99 = require "99"

      -- The `claude` CLI has no "list models" command, so 99 hardcodes the
      -- picker list (lua/99/providers.lua) and it currently stops at opus-4-6.
      -- Override fetch_models so <leader>9m offers the current lineup.
      _99.Providers.ClaudeCodeProvider.fetch_models = function(cb)
        cb({
          "claude-opus-4-8",
          "claude-opus-4-7",
          "claude-opus-4-6",
          "claude-sonnet-4-6",
          "claude-sonnet-4-5",
          "claude-haiku-4-5",
        }, nil)
      end

      _99.setup {
        provider = _99.Providers.ClaudeCodeProvider,
        md_files = { "AGENTS.md", "AGENT.md", "CLAUDE.md", "GEMINI.md" },
        completion = {
          custom_rules = { "~/.claude/skills", ".claude/skills" },
          source = "cmp",
        },
        model = "claude-opus-4-8",
      }
      local map = vim.keymap.set
      map("n", "<leader>9s", function() _99.search() end,            { desc = "99: [S]earch / ask Claude" })
      map("v", "<leader>9v", function() _99.visual() end,            { desc = "99: send [V]isual selection (prompts)" })
      map("n", "<leader>9o", function() _99.open() end,              { desc = "99: [O]pen last result" })
      map("n", "<leader>9x", function() _99.stop_all_requests() end, { desc = "99: stop all requests" })
      map("n", "<leader>9i", function() _99.info() end,              { desc = "99: [I]nfo / status" })
      map("n", "<leader>9l", function() _99.view_logs() end,         { desc = "99: view [L]ogs" })
      map("n", "<leader>9m", function()
        require("99.extensions.telescope").select_model()
      end, { desc = "99: select [M]odel" })
    end,
  },

  -- Discord rich presence
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require("presence").setup {
        auto_update         = true,
        neovim_image_text   = "NeoVim dees nuts",
        main_image          = "neovim",
        client_id           = "793271441293967371",
        log_level           = nil,
        debounce_timeout    = 10,
        enable_line_number  = false,
        blacklist           = {},
        buttons             = true,
        file_assets         = {},
        show_time           = true,
        editing_text        = "Editing %s",
        file_explorer_text  = "Browsing %s",
        git_commit_text     = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text        = "Reading %s",
        workspace_text      = "Working on %s",
        line_number_text    = "Line %s out of %s",
      }
    end,
  },

  -- Better-escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup { timeout = 100 }
    end,
  },

  -- Mason: install our binaries
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", "stylua",
        "css-lsp", "html-lsp", "typescript-language-server",
        "deno", "prettierd", "biome",
      },
    },
  },
}
