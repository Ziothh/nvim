M = {}

-- Uses the NvChad style of configuring keymaps. 
-- @param mappings: { [mode] = { [keymap] = { function() | string, description, options } } }
-- @param mapping_opt: default options for every keymap
M.set_mappings = function(mappings, mapping_opt)
  mappings.plugin = nil -- removing some nvchad thing that's set on some mappings (see core.mappings)

  vim.schedule(function()
    for mode, mode_values in pairs(mappings) do
      local default_opts = vim.tbl_deep_extend("force", { mode = mode }, mapping_opt or {})

      for keybind, mapping_info in pairs(mode_values) do
        -- merge default + user opts
        local opts = vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})

        mapping_info.opts, opts.mode = nil, nil
        opts.desc = mapping_info[2]

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end)
end

return M
