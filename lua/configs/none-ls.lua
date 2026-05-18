local null_ls = require "null-ls"

local M = {
  eslint_enabled = false,
  prettier_enabled = true,
}

local sources = {
  null_ls.builtins.formatting.stylua,
}

if M.eslint_enabled then
  table.insert(sources, null_ls.builtins.diagnostics.eslint_d.with {
    diagnostics_format = "[eslint] #{m}\n(#{c})",
  })
  table.insert(sources, null_ls.builtins.code_actions.eslint_d)
end

if M.prettier_enabled then
  table.insert(sources, null_ls.builtins.formatting.prettierd.with {
    filetypes = {
      "css", "javascript", "javascriptreact",
      "typescript", "typescriptreact",
      "json", "markdown", "scss", "less",
    },
  })
end

M.setup = function()
  if not M.eslint_enabled and not M.prettier_enabled then return end
  null_ls.setup { debug = false, sources = sources }
end

return M
