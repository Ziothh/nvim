vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
  float = { border = "rounded" },
}

local map = vim.keymap.set

map("n", "<leader>dp", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "[D]iagnostic: [P]revious", silent = true, noremap = true })

map("n", "<leader>dn", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "[D]iagnostic: [N]ext", silent = true, noremap = true })

map("n", "<leader>d", vim.diagnostic.open_float, {
  desc = "Open diagnostic on cursor",
  silent = true,
  noremap = true,
})
map("n", "<leader>dd", vim.diagnostic.open_float, {
  desc = "Open diagnostic on cursor",
  silent = true,
  noremap = true,
})

map("n", "<leader>dl", vim.diagnostic.setloclist, {
  desc = "Open [D]iagnostic [L]ist",
  silent = true,
  noremap = true,
})

-- Toggle virtual_text on/off
vim.g.diagnostics_active = true
map("n", "<leader>d<S-t>", function()
  vim.g.diagnostics_active = not vim.g.diagnostics_active
  vim.diagnostic.config { virtual_text = vim.g.diagnostics_active }
end, { desc = "[D]iagnostics [T]oggle virtual_text", noremap = true, silent = true })

-- Toggle severity-reduced view (ERROR only ⇄ all)
vim.g.diagnostics_reduced = false
map("n", "<leader>dt", function()
  vim.g.diagnostics_reduced = not vim.g.diagnostics_reduced
  if vim.g.diagnostics_reduced then
    vim.diagnostic.config {
      virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
    }
  else
    vim.diagnostic.config { virtual_text = true }
  end
end, { desc = "[D]iagnostics [T]oggle severity reduction", noremap = true, silent = true })
