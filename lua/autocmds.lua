require "nvchad.autocmds"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank { timeout = 100 }
  end,
})


vim.filetype.add {
  extension = { mdc = "markdown" },
  pattern = { [".env.*"] = "sh" },
}

-- Restore v2.0 LSP keymaps that aren't in NvChad v2.5 defaults.
-- Nvim 0.11+ ships gri/grr/grn/gra; gra is unmapped below in favor of <leader>ca.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "LSP implementation" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "LSP references" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "LSP code action" })
    pcall(vim.keymap.del, "n", "gra", { buffer = buf })
    pcall(vim.keymap.del, "x", "gra", { buffer = buf })
  end,
})

-- JSX/TSX attribute names (className, onClick, ...) — blend with normal
-- variables instead of catppuccin's default red. Applied via autocmd so it
-- re-runs after every ColorScheme load (base46 recompiles wipe inline hl_set
-- otherwise).
require "configs.diagnostics"
