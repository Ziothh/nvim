local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  }

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[?] Find recently opened files', noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind existing [B]uffers', noremap = true, silent = true })
vim.keymap.set('n', '<leader><space>', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[ ] Fuzzily search in current buffer]', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles', noremap = true, silent = true,  })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "[F]ind [G]it controlled files", noremap = true, silent = true, })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp', noremap = true, silent = true,  })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = '[F]ind [W]ord by Grep', noremap = true, silent = true, })
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- vim.keymap.set('n', '<leader>fw', function()
-- end, { desc = "[F]ind [W]ords", })
-- vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
-- vim.keymap.set('v', '<leader>fw', ' y<ESC>:Telescope live_grep', { desc = "[F]ind [W]ord by Grep and yank current selected text", noremap = true, silent = true, }) -- multiple words doesn't work
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics', noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)

