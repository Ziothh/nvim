local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local rust_tools = require "rust-tools"
local lspconfig = require "lspconfig"

-- rust_tools.setup {
--   server = {
--     on_attach = function(_, bufnr)
--       -- Hover actions
--       vim.keymap.set("n", "<S-k>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
--       -- Code action groups
--       vim.keymap.set("n", "<Leader>ca", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
--     end,
--   },
-- }

-- lspconfig.rust_analyzer.setup {
--   flags = {
--     allow_incremental_sync = true,
--     debounce_text_changes = 200,
--   },
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--       checkOnSave = {
--         allFeatures = true,
--         command = "clippy",
--       },
--       procMacro = {
--         ignored = {
--           ["async-trait"] = { "async_trait" },
--           ["napi-derive"] = { "napi" },
--           ["async-recursion"] = { "async_recursion" },
--         },
--       },
--     },
--   },
-- }

-- if you just want default config for the servers then put them in a table
-- local servers = {
--   --
--   "html",
--   "cssls",
--   "tsserver",
--   "clangd",
--   -- "rust_analyzer", -- is handled above
-- }
--
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = function(client, bufnr)
--       print(lsp, client.server_capabilities.documentSymbolProvider)
--       if client.server_capabilities.documentSymbolProvider then
--         local navic = require "nvim-navic"
--         navic.attach(client, bufnr)
--       end
--
--       on_attach(client, bufnr)
--     end,
--     capabilities = capabilities,
--   }
-- end

--
-- lspconfig.pyright.setup { blabla}



local M = {}

-- lspconfig.rust_analyzer.setup {
--   flags = {
--     allow_incremental_sync = true,
--     debounce_text_changes = 200,
--   },
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--       checkOnSave = {
--         allFeatures = true,
--         command = "clippy",
--       },
--       procMacro = {
--         ignored = {
--           ["async-trait"] = { "async_trait" },
--           ["napi-derive"] = { "napi" },
--           ["async-recursion"] = { "async_recursion" },
--         },
--       },
--     },
--   },
-- }

local servers = {
  -- "rust_analyzer", -- is handled above
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  html = {},
  cssls = {},
  clangd = {},
  tailwindcss = {},
  jsonls = {
    json = {
      schemas = {
        {
          description = "Javascript configuration file",
          fileMatch = { "package.json" },
          url = "http://json.schemastore.org/package.json",
        },
        {
          description = "TypeScript compiler configuration file",
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "http://json.schemastore.org/tsconfig",
        },
        {
          description = "Lerna config",
          fileMatch = { "lerna.json" },
          url = "http://json.schemastore.org/lerna",
        },
        -- {
        --   description = "Babel configuration",
        --   fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
        --   url = "http://json.schemastore.org/lerna",
        -- },
        {
          description = "ESLint config",
          fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "http://json.schemastore.org/eslintrc",
        },
        -- {
        --   description = "Bucklescript config",
        --   fileMatch = { "bsconfig.json" },
        --   url = "https://bucklescript.github.io/bucklescript/docson/build-schema.json",
        -- },
        {
          description = "Prettier config",
          fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "http://json.schemastore.org/prettierrc",
        },
        {
          description = "Vercel Now config",
          fileMatch = { "now.json" },
          url = "http://json.schemastore.org/now",
        },
        {
          description = "Stylelint config",
          fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
          url = "http://json.schemastore.org/stylelintrc",
        },
      },
    },
  },
  emmet_ls = {
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    },
  },
}

M.setup = function(on_attach, capabilities)
  local null_ls = require "custom.configs.null-ls"

  for lsp, _ in pairs(servers) do
    if servers[lsp]["capabilities"] == nil then
      servers[lsp]["capabilities"] = {}
    end

    lspconfig[lsp].setup {
      on_attach = function(client, bufnr)
        -- NvChad defaults
        on_attach(client, bufnr)

        if client.server_capabilities.documentSymbolProvider then
          local navic = require "nvim-navic"
          navic.attach(client, bufnr)
        end

        local settings = servers[lsp]
        if settings and settings["on_attach"] then
          settings.on_attach(client, bufnr)
        end
      end,
      capabilities = capabilities,
      settings = servers[lsp],
    }
  end

  lspconfig["tsserver"].setup {
    capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      if null_ls.eslint_enabled == false then
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end
    end,
   -- filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
   -- cmd = { "typescript-language-server", "--stdio" }
    ---@diagnostic disable-next-line: unused-local
    -- on_attach = function(client, _bufnr)
    --   local null_ls = require "custom.configs.null-ls"
    --
    --   if null_ls.eslint_enabled == false then
    --     client.server_capabilities.documentFormattingProvider = true
    --     client.server_capabilities.documentRangeFormattingProvider = true
    --   end
    --   --   client.server_capabilities.documentFormattingProvider = false -- For eslint
    --   --   -- client.server_capabilities.documentFormattingProvider = false
    --   --   on_attach(client, bufnr)
    --   --   vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>:Format<CR>", {}) -- command defined in the global on_attach
    -- end,
    -- documentFormattingProvider = false,
    -- document_formatting = false,
    -- -- on_attach = on_attach,
    -- filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    -- cmd = { "typescript-language-server", "--stdio" }
  }
end

return M
