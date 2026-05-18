local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults()

-- Servers that get the NvChad defaults verbatim (on_attach, capabilities)
local servers = {
  "gopls",
  "pyright",
  "lua_ls",
  "html",
  "cssls",
  "prismals",
  "clangd",
  "nil_ls",
  "terraformls",
  "marksman",
  "yamlls",
}
vim.lsp.enable(servers)

-- tailwindcss: disable inline color swatches at the server level so it stops
-- returning textDocument/documentColor entirely.
vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      colorDecorators = false,
    },
  },
})
vim.lsp.enable "tailwindcss"

-- Servers with per-server overrides
vim.lsp.config("graphql", {
  filetypes = { "graphql", "typescript", "typescriptreact", "javascriptreact" },
})
vim.lsp.enable "graphql"

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = {
        { description = "Javascript configuration file", fileMatch = { "package.json" },
          url = "http://json.schemastore.org/package.json" },
        { description = "TypeScript compiler configuration file", fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "http://json.schemastore.org/tsconfig" },
        { description = "Lerna config", fileMatch = { "lerna.json" },
          url = "http://json.schemastore.org/lerna" },
        { description = "ESLint config", fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "http://json.schemastore.org/eslintrc" },
        { description = "Prettier config", fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "http://json.schemastore.org/prettierrc" },
        { description = "Vercel Now config", fileMatch = { "now.json" },
          url = "http://json.schemastore.org/now" },
        { description = "Stylelint config", fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
          url = "http://json.schemastore.org/stylelintrc" },
      },
    },
  },
})
vim.lsp.enable "jsonls"

-- ts_ls:
-- - none-ls/prettier owns JS/TS formatting, so ts_ls stays out
-- - don't advertise semantic-tokens support so treesitter highlighting stays in charge
-- - opt in to the experimental Go-based tsserver (tsgo) for both TS and JS
vim.lsp.config("ts_ls", {
  capabilities = {
    textDocument = {
      semanticTokens = vim.NIL,
    },
  },
  settings = {
    typescript = { experimental = { useTsgo = true } },
    javascript = { experimental = { useTsgo = true } },
  },
  on_attach = function(client, _bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
vim.lsp.enable "ts_ls"

vim.lsp.config("emmet_ls", {
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
})
vim.lsp.enable "emmet_ls"
