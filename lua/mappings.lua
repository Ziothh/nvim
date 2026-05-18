require "nvchad.mappings"

local map = vim.keymap.set
local del = function(modes, lhs)
  for _, m in ipairs(type(modes) == "table" and modes or { modes }) do
    pcall(vim.keymap.del, m, lhs)
  end
end

-- Strip nvchad.term mappings (terminal plugin not used)
del({ "n", "t" }, "<A-i>")
del({ "n", "t" }, "<A-h>")
del({ "n", "t" }, "<A-v>")
del("n", "<leader>h")
del("n", "<leader>v")

-- enter command mode with `;`
map("n", ";", ":", { desc = "CMD enter command mode", nowait = true })

-- silence some defaults
map("n", "<Space>", "<Nop>")
map("n", "<F1>", "<Nop>")
map("n", "Q", "<Nop>")

-- v2.0 motion/edit tweaks
-- j/k by display line (preserves count for `5j` etc.)
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down (display line)" })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up (display line)" })
map({ "n", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- visual indent keeps selection
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })
-- visual paste without yanking replaced text
map("x", "p", '"_dP', { desc = "Paste without yank" })

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

-- GitSigns (deferred require — plugin loads on User FilePost)
local gs = function(action)
  return function() require("gitsigns")[action]() end
end
map("n", "]c", gs "next_hunk",     { desc = "Git: next hunk" })
map("n", "[c", gs "prev_hunk",     { desc = "Git: prev hunk" })
map("n", "<leader>rh", gs "reset_hunk",     { desc = "Git: reset hunk" })
map("n", "<leader>ph", gs "preview_hunk",   { desc = "Git: preview hunk" })
map("n", "<leader>gb", gs "blame_line",     { desc = "Git: blame line" })
map("n", "<leader>td", gs "toggle_deleted", { desc = "Git: toggle deleted" })
