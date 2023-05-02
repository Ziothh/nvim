-- [[ General config ]]
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
  float = { border = "rounded" },
  -- underline = {
  --   severity = { max = vim.diagnostic.severity.INFO },
  -- },
  -- virtual_text = {
  --   severity = { min = vim.diagnostic.severity.WARN },
  -- },
  -- severity_sort
}

-- [[ Keymaps ]]
vim.keymap.set(
  "n",
  "<leader>dp",
  vim.diagnostic.goto_prev,
  { desc = "[E]rror: [P]revious", silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "[E]rror: [N]ext", silent = true, noremap = true })
vim.keymap.set(
  "n",
  "<leader>d",
  vim.diagnostic.open_float,
  { desc = "Open [E]rror on cursor", silent = true, noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>dd",
  vim.diagnostic.open_float,
  { desc = "Open [E]rror on cursor", silent = true, noremap = true }
)
-- vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = "Open [E]rror on cursor", silent = true, noremap = true })
vim.keymap.set(
  "n",
  "<leader>dl",
  vim.diagnostic.setloclist,
  { desc = "Open [E]rror [L]ist", silent = true, noremap = true }
)

vim.g.diagnostics_active = true
vim.keymap.set("n", "<leader>d<S-t>", function()
  local isActive = vim.g.diagnostics_active
  if isActive then
    -- vim.diagnostic.hide()
    vim.diagnostic.config { virtual_text = false }
  else
    -- vim.diagnostic.show()
    vim.diagnostic.config { virtual_text = true }
  end

  vim.g.diagnostics_active = not isActive
  -- if vim.g.diagnostics_active then
  --   vim.g.diagnostics_active = false
  --   vim.diagnostic.hide()
  --   vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  -- else
  --   vim.g.diagnostics_active = true
  --   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --     vim.diagnostic.on_publish_diagnostics, {
  --     virtual_text = true,
  --     signs = true,
  --     underline = true,
  --     update_in_insert = false,
  --   }
  --   )
  -- end
end, { desc = "[D]iagnostics [T]oggle on/off", noremap = true, silent = true })

vim.g.diagnostics_reduced = false
vim.keymap.set("n", "<leader>dt", function()
  vim.g.diagnostics_reduced = not vim.g.diagnostics_reduced

  print(vim.g.diagnostics_reduced)

  if vim.g.diagnostics_reduced then
    vim.diagnostic.config {
      virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
    }
  else
    vim.diagnostic.config {
      -- virtual_text = {
      --   severity = { min = vim.diagnostic.severity.INFO },
      -- },
      virtual_text = true,
    }
  end
end, { desc = "[D]iagnostics [T]oggle Severity WARN/INFO", noremap = true, silent = true })
