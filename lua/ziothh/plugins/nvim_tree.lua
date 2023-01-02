-- examples for your init.lua

-- disable netrw (vims builtin file explorer) at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  view = {
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here

        -- END_DEFAULT_MAPPINGS
        -- { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
        -- { key = "<C-e>", action = "edit_in_place" },
        -- { key = "O", action = "edit_no_picker" },
        -- { key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
        -- { key = "<C-v>", action = "vsplit" },
        -- { key = "<C-x>", action = "split" },
        -- { key = "<C-t>", action = "tabnew" },
        -- { key = "<", action = "prev_sibling" },
        -- { key = ">", action = "next_sibling" },
        -- { key = "P", action = "parent_node" },
        -- { key = "<BS>", action = "close_node" },
        -- { key = "<Tab>", action = "preview" },
        -- { key = "K", action = "first_sibling" },
        -- { key = "J", action = "last_sibling" },
        -- { key = "C", action = "toggle_git_clean" },
        -- { key = "I", action = "toggle_git_ignored" },
        -- { key = "H", action = "toggle_dotfiles" },
        -- { key = "B", action = "toggle_no_buffer" },
        -- { key = "U", action = "toggle_custom" },
        -- { key = "R", action = "refresh" },
        -- { key = "a", action = "create" },
        -- { key = "d", action = "remove" },
        -- { key = "D", action = "trash" },
        -- { key = "r", action = "rename" },
        -- { key = "<C-r>", action = "full_rename" },
        -- { key = "e", action = "rename_basename" },
        -- { key = "x", action = "cut" },
        -- { key = "c", action = "copy" },
        -- { key = "p", action = "paste" },
        -- { key = "y", action = "copy_name" },
        -- { key = "Y", action = "copy_path" },
        -- { key = "gy", action = "copy_absolute_path" },
        -- { key = "[e", action = "prev_diag_item" },
        -- { key = "[c", action = "prev_git_item" },
        -- { key = "]e", action = "next_diag_item" },
        -- { key = "]c", action = "next_git_item" },
        -- { key = "-", action = "dir_up" },
        -- { key = "s", action = "system_open" },
        -- { key = "f", action = "live_filter" },
        -- { key = "F", action = "clear_live_filter" },
        -- { key = "q", action = "close" },
        -- { key = "W", action = "collapse_all" },
        -- { key = "E", action = "expand_all" },
        -- { key = "S", action = "search_node" },
        -- { key = ".", action = "run_file_command" },
        -- { key = "<C-k>", action = "toggle_file_info" },
        -- { key = "g?", action = "toggle_help" },
        -- { key = "m", action = "toggle_mark" },
        -- { key = "bmv", action = "bulk_move" },
      },
    },
  }
})

-- OR setup with some options
-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   view = {
--     adaptive_size = true,
--     mappings = {
--       list = {
--         { key = "u", action = "dir_up" },
--       },
--     },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })

vim.keymap.set("n", "<leader>et", "<cmd>NvimTreeFindFileToggle<cr>",
  { desc = "[E]xplorer [T]oggle NvimTree on current buffer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeToggle<cr>", { desc = "[E]xplorer [T]oggle NvimTree on root of project" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "[E]xplorer [C]ollapse NvimTree (recursively)" })
vim.keymap.set("n", "<leader>ecc", "<cmd>NvimTreeCollapseKeepBuffers<cr>",
  { desc = "[E]xplorer [C]ollapse NvimTree (recursively but keep direcotries of current buffers open)" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<cr>", { desc = "[E]xplorer [F]ocus NvimTree" })
