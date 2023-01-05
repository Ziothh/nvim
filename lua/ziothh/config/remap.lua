-- local k = vim.keymap;

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- vim.keymap.set('n', '<C-Space>', '<nop>', { silent = true, noremap = true })

-- This is going to get me cancelled -- threprimeagen
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disabling some movements
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<F1>", "<nop>")


-- [[ Vim navigation ]]
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- [[ Text editing ]]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "[J] Move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "[K] Move selected line up" })

vim.keymap.set("n", "J", "mzJ`z") -- replace newline of next line with a space

vim.keymap.set("n", "x", '"_x') -- Delete character without adding it to the buffer

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- ?

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- allows pasting buffer over highlighted text without losing that buffer

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]],
  { desc = "copies text to your systems clipboard instead of your vim buffer" })
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- ?

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- -- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Movement ]]
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page jumping down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page jumping up" })

vim.keymap.set("n", "n", "nzzzv") -- ?
vim.keymap.set("n", "N", "Nzzzv") -- ?


-- Window management
-- k.set("n", "<leader>sv", "<C-w>v") -- split window vertically
-- k.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
-- k.set("n", "<leader>se", "<C-w>=") -- split window with equal width
-- k.set("n", "<leader>sx", ":close<CR>") -- close current window

-- Tab management
-- k.set("n", "<leader>to", ":tabnew<CR>")
-- k.set("n", "<leader>tx", ":tabclose<CR>")
-- k.set("n", "<leader>tn", ":tabn<CR>")
-- k.set("n", "<leader>tp", ":tabp<CR>")

-- vim.keymap.set("n", "<leader>vwm", function()
-- require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--   require("vim-with-me").StopVimWithMe()
-- end)


-- [[ Buffers ]]
vim.keymap.set("n", "<leader>bp", ":b#<CR>", { desc = "[B]uffer: [P]revious" })


-- [[ Git ]]
vim.keymap.set("n", "<leader>ga", function()
  local files = vim.fn.input("Git add files > ")

  if (files and files ~= "")
  then
    vim.cmd("!git add " .. files)
  end
end, { desc = "[G]it [A]dd", silent = true })
vim.keymap.set("n", "<leader>gaa", "!git add -A", { desc = "[G]it [A]dd [A]ll" })
vim.keymap.set("n", "<leader>gc", function()
  vim.ui.input({ prompt = "Git commit message > " }, function(message)
    if (message and message ~= "")
    then
      vim.cmd("!git commit -m \"" .. message .. '"')
    end
  end)
end, { desc = "[G]it [C]ommit" })
vim.keymap.set("n", "<leader>gca", function()
  vim.ui.input({ prompt = "Git commit message > " }, function(message)
    if (message and message ~= "")
    then
      vim.cmd("!git add -A && git commit -m \"" .. message .. '"')
    end
  end)
end, { desc = "[G]it [C]ommit by staging [A]ll" })
vim.keymap.set("n", "<leader>gp!", ":Git push<CR>", { desc = "[G]it [P]ush" })


-- [[ tmux ]]
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat file" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- start replace current text command
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- cmod a script to be executable
