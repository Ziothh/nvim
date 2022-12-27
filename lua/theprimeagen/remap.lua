local k = vim.keymap;

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected line up

vim.keymap.set("n", "J", "mzJ`z") -- replace newline of next line with a space
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- half page jumping down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- half page jumping up
vim.keymap.set("n", "n", "nzzzv") -- ?
vim.keymap.set("n", "N", "Nzzzv") -- ?

k.set("n", "x", '"_x') -- Delete character without adding it to the buffer

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

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- allows pasting buffer over highlighted text without losing that buffer

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- copies text to your systems clipboard instead of your vim buffer
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- ?

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]]) -- ?

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- start replace current text command
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- cmod a script to be executable

