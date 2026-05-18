local M = {}

M.setup = function()
  local null_ls = require "null-ls"
  null_ls.setup {
    debug = false,
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "css", "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "json", "markdown", "scss", "less",
        },
      },
    },
  }
end

return M
