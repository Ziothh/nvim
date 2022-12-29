local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>pa", mark.add_file, { desc = "[A]dd current file to harpoon"})
vim.keymap.set("n", "<leader>pe", ui.toggle_quick_menu, { desc = "Open harpoon menu" })

vim.keymap.set("n", "<C-&>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-é>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-\">", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-'>", function() ui.nav_file(4) end)


