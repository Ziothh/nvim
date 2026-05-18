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

-- ts_ls: disable formatting when none-ls/prettier handles JS/TS
vim.lsp.config("ts_ls", {
  on_attach = function(client, _bufnr)
    local none_ls = require "configs.none-ls"
    local is_formatter = not none_ls.eslint_enabled
    client.server_capabilities.documentFormattingProvider = is_formatter
    client.server_capabilities.documentRangeFormattingProvider = is_formatter
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
