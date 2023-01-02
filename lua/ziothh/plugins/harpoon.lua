local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>pa", mark.add_file, { desc = "[A]dd current file to harpoon"})
vim.keymap.set("n", "<leader>pe", ui.toggle_quick_menu, { desc = "Open harpoon menu" })

vim.keymap.set("n", "<leader>pp", ui.nav_prev, { desc = "[P]revious harpoon file"})
vim.keymap.set("n", "<leader>pn", ui.nav_next, { desc = "[N]ext harpoon file"})

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)


