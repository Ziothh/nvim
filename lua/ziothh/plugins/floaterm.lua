-- FloaTerm configuration
vim.keymap.set('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 <CR> ", {desc = "Create new [F]float [T]erm"})
vim.keymap.set('n', "t", ":FloatermToggle myfloat<CR>", {desc = "Toggle [T]erminal"})
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:q<CR>", {desc = "Hide [T]erminal window"})

