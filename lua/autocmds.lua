require "nvchad.autocmds"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank { timeout = 100 }
  end,
})

-- Disable 0.12's inline color swatches (noisy with some LSP servers).
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.lsp.document_color.enable(false, { bufnr = ev.buf })
  end,
})

vim.filetype.add {
  extension = { mdc = "markdown" },
  pattern = { [".env.*"] = "sh" },
}

require "configs.diagnostics"
