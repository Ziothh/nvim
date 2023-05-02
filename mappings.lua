---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<Space>"] = { "<Nop>" },
    ["<F1>"] = { "<Nop>" },
    ["Q"] = { "<Nop>" },
    ["<leader>X"] = {
      function()
        require("nvchad_ui.tabufline").closeAllBufs()
      end,
      "Close all buffers"
    },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["x"] = { '"_x', "Delete char without overwriting to copy buffer" },
    ["<C-d>"] = { "<C-d>zz", "Half page jumping down" },
    ["<C-u>"] = { "<C-u>zz", "Half page jumping up" },
    ["n"] = { "nzzzv" },
    ["<leader>f"] = { vim.lsp.buf.format, "[F]ormat buffer" },
    ["<leader>bp"] = { ":b#<CR>", "[B]uffer: [P]revious" },

    ["<leader>gca"] = {
      function()
        vim.ui.input({ prompt = "Git commit message > " }, function(message)
          if message and message ~= "" then
            vim.cmd('!git add -A && git commit -m "' .. message .. '"')
          end
        end)
      end,

      "[G]it [C]ommit by staging [A]ll",
    },
    ["<leader>gp!"] = { ":!git push<CR>", "[G]it [P]ush" },

    ["<leader><space>"] = {
      function()
        local telescope = require "telescope"
        local builtin = require "telescope.builtin"
        local themes = require "telescope.themes"
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find()
        -- builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        --   winblend = 10,
        --   previewer = false,
        -- })
      end,
      "[ ] Fuzzily search in current buffer]",
      { noremap = true, silent = true },
    },

    ["<leader>fd"] = {
      function()
        local telescope = require "telescope"
        local builtin = require "telescope.builtin"
        local themes = require "telescope.themes"

        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.diagnostics()
        -- builtin.diagnostics(themes.get_dropdown {
        --   winblend = 10,
        --   previewer = false,
        -- })
      end,
      "[F]ind [D]iagnostics",
      { noremap = true, silent = true },
    },
    -- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
    -- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
    -- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
    -- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "[J] Move selected line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "[K] Move selected line up" },
  },
  x = {},
}

-- more keybinds!

return M
