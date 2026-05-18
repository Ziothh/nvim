require "nvchad.mappings"

local map = vim.keymap.set

-- enter command mode with `;`
map("n", ";", ":", { desc = "CMD enter command mode", nowait = true })

-- silence some defaults
map("n", "<Space>", "<Nop>")
map("n", "<F1>", "<Nop>")
map("n", "Q", "<Nop>")

-- delete char without overwriting clipboard
map("n", "x", '"_x', { desc = "Delete char w/o yank" })

-- keep cursor centered on half-page jumps & search
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next match (centered)" })

-- format buffer via LSP
map("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat buffer" })

-- previous buffer
map("n", "<leader>bp", ":b#<CR>", { desc = "[B]uffer: [P]revious" })

-- git commit-all + push
map("n", "<leader>gca", function()
  vim.ui.input({ prompt = "Git commit message > " }, function(message)
    if message and message ~= "" then
      vim.cmd('!git add -A && git commit -m "' .. message .. '"')
    end
  end)
end, { desc = "[G]it [C]ommit by staging [A]ll" })

map("n", "<leader>gp!", ":!git push<CR>", { desc = "[G]it [P]ush" })

-- close all buffers
map("n", "<leader>xa", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close all buffers" })

-- chmod +x current file
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = "chmod +x current file", silent = true })

-- telescope: fuzzy find in current buffer + diagnostics + nvim config
map("n", "<leader><space>", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Fuzzily search in current buffer", noremap = true, silent = true })

map("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics()
end, { desc = "[F]ind [D]iagnostics", noremap = true, silent = true })

map("n", "<leader>fn", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath "config",
  }
end, { desc = "[F]ind [N]eoVim config files", noremap = true, silent = true })

-- visual: move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
