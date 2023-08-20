local M = {}

M.setup = function()
  local rust_tools = require "rust-tools"

  rust_tools.setup {
    tools = {
      runnables = {
        use_telescope = true,
      },
      -- inlay_hints = {
      --   auto = true,
      --   show_parameter_hints = false,
      --   parameter_hints_prefix = "",
      --   other_hints_prefix = "",
      -- },
    },
    server = {
      on_attach = function(client, bufnr)
        -- local file = io.open( "/home/zioth/temp/debug.txt", "w" )
        -- file:write(
        --   require('custom.dependencies.inspect').inspect(
        --   )          
        -- )
        -- file:close()

        require("custom.utils").set_mappings(
          -- -- Default NvChad mappings with some custom rust-tools overrides
          vim.tbl_deep_extend("force", require("core.mappings").lspconfig, {
            n = {
              ["K"] = { rust_tools.hover_actions.hover_actions, { buffer = bufnr } },
              ["<leader>ca"] = { rust_tools.code_action_group.code_action_group, { buffer = bufnr } },
            },
          })
        )

        -- client.server_capabilities.documentFormattingProvider = true
        -- client.server_capabilities.documentRangeFormattingProvider = true
        -- Hover actions
        -- vim.keymap.set("n", "<S-k>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        -- vim.keymap.set("n", "<Leader>ca", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
        -- vim.g.rust_recommended_style = 0
      end,
    },
  }
end

return M
