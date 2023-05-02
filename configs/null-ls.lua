local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local M = {
  -- eslint_enabled = true,
  eslint_enabled = false,
}

local sources = {

  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  -- b.formatting.prettier.with {
  --   filetypes = {
  --     "css",
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --     "json",
  --     "scss",
  --     "less",
  --   },
  -- }, -- so prettier works only on these filetypes

  b.formatting.stylua,

  -- null_ls.builtins.diagnostics.fish,
  -- cpp
  -- b.formatting.clang_format,
}

if M.eslint_enabled then
  table.insert(sources, null_ls.builtins.diagnostics.eslint_d.with {
    diagnostics_format = "[eslint] #{m}\n(#{c})",
  })

  table.insert(sources, null_ls.builtins.code_actions.eslint_d)
  table.insert(sources, null_ls.builtins.formatting.eslint_d)
end

M.setup = function()
  -- Disable when not in an eslint project
  if M.eslint_enabled == false then
    return
  end

  null_ls.setup {
    debug = true,
    sources = sources,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        local navic = require "nvim-navic"
        navic.attach(client, bufnr)
      end
    end,
  }
end

return M
