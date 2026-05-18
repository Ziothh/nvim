-- nvim-cmp configuration.
-- Called with the NvChad-provided default `opts` table; mutates it then
-- runs cmp.setup. Also configures cmdline-mode completion.

return function(opts)
  local cmp = require "cmp"

  -- Insert mode: <Tab> confirms; <S-Tab> and <CR> fall through to native
  -- behaviour (so <CR> still inserts a newline). Menu navigation is <C-n>/<C-p>.
  opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
    ["<CR>"] = cmp.config.disable,
    ["<S-Tab>"] = cmp.config.disable,
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  })

  cmp.setup(opts)

  -- Cmdline mode: <Tab> confirms current item or triggers completion.
  local cmdline_mapping = cmp.mapping.preset.cmdline {
    ["<Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }
      else
        cmp.complete()
      end
    end, { "c" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback) fallback() end, { "c" }),
  }

  local cmdline_formatting = { fields = { "abbr" } }

  cmp.setup.cmdline(":", {
    mapping = cmdline_mapping,
    formatting = cmdline_formatting,
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmdline_mapping,
    formatting = cmdline_formatting,
    sources = { { name = "buffer" } },
  })
end
