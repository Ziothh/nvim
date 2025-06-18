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
                -- vim.api.nvim_set_hl(0, "DiagnosticHint", { link = "GruvboxFg2" })
                -- vim.api.nvim_set_hl(0, "DiagnosticSignHint", { link = "GruvboxFg2" })
                -- vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { link = "GruvboxFg2" })
                -- vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#d5c4a1" })
                -- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "GruvboxFg2" })

                -- vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
                --
                -- vim.api.nvim_set_hl(0, "@none", { bg = "NONE", fg = "NONE" })
                -- vim.api.nvim_set_hl(0, "@text.strong", { bold = true })
                -- vim.api.nvim_set_hl(0, "@text.emphasis", { italic = true })
                -- vim.api.nvim_set_hl(0, "@text.underline", { underline = true })
                -- vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true })

                -- treesitter and LSP links to default groups
                local links = {
                    ["@comment"] = "Comment",
                    ["@preproc"] = "PreProc",
                    ["@define"] = "Define",
                    ["@operator"] = "Operator",

                    ["@punctuation.delimiter"] = "Delimiter",
                    ["@punctuation.bracket"] = "Delimiter",
                    ["@punctuation.special"] = "Delimiter",

                    ["@string"] = "String",
                    ["@string.regex"] = "String",
                    ["@string.escape"] = "SpecialChar",
                    ["@string.special"] = "SpecialChar",

                    ["@character"] = "Character",
                    ["@character.special"] = "SpecialChar",

                    ["@boolean"] = "Boolean",
                    ["@number"] = "Number",
                    ["@float"] = "Float",

                    ["@function"] = "Function",
                    ["@function.call"] = "Function",
                    ["@function.builtin"] = "Special",
                    ["@function.macro"] = "Macro",

                    ["@method"] = "Function",
                    ["@method.call"] = "Function",

                    ["@constructor"] = "Special",
                    ["@parameter"] = "Identifier",

                    ["@keyword"] = "Keyword",
                    ["@keyword.function"] = "Keyword",
                    ["@keyword.operator"] = "Keyword",
                    ["@keyword.return"] = "Keyword",

                    ["@conditional"] = "Conditional",
                    ["@repeat"] = "Repeat",
                    ["@debug"] = "Debug",
                    ["@label"] = "Label",
                    ["@include"] = "Include",
                    ["@exception"] = "Exception",

                    ["@type"] = "Type",
                    ["@type.builtin"] = "Type",
                    ["@type.qualifier"] = "Type",
                    ["@type.definition"] = "Typedef",

                    ["@storageclass"] = "StorageClass",
                    ["@attribute"] = "PreProc",
                    ["@field"] = "Identifier",
                    ["@property"] = "Identifier",

                    ["@variable"] = "Normal",
                    ["@variable.builtin"] = "Special",

                    ["@constant"] = "Constant",
                    ["@constant.builtin"] = "Special",
                    ["@constant.macro"] = "Define",

                    ["@namespace"] = "Include",
                    ["@symbol"] = "Identifier",

                    ["@text"] = "Normal",
                    ["@text.title"] = "Title",
                    ["@text.literal"] = "String",
                    ["@text.uri"] = "Underlined",
                    ["@text.math"] = "Special",
                    ["@text.environment"] = "Macro",
                    ["@text.environment.name"] = "Type",
                    ["@text.reference"] = "Constant",

                    ["@text.todo"] = "Todo",
                    ["@text.note"] = "SpecialComment",
                    ["@text.warning"] = "WarningMsg",
                    ["@text.danger"] = "ErrorMsg",

                    ["@tag"] = "Tag",
                    ["@tag.attribute"] = "Identifier",
                    ["@tag.delimiter"] = "Delimiter",
                    ["@lsp.type.namespace"] = "Structure", -- "@namespace" makes `mod xxx` all blue
                    ["@lsp.type.type"] = "@type",
                    ["@lsp.type.class"] = "@type",
                    ["@lsp.type.enum"] = "@type",
                    ["@lsp.type.interface"] = "@type",
                    ["@lsp.type.struct"] = "@structure",
                    ["@lsp.type.parameter"] = "@parameter",
                    ["@lsp.type.variable"] = "@variable",
                    ["@lsp.type.property"] = "@property",
                    ["@lsp.type.enumMember"] = "@constant",
                    ["@lsp.type.function"] = "@function",
                    ["@lsp.type.method"] = "@method",
                    ["@lsp.type.macro"] = "@macro",
                    ["@lsp.type.decorator"] = "@function",
                    -- ["@lsp.mod.defaultLibrary"] = "@function.builtin", -- Makes macros blue
                    ["@lsp.mod.readonly"] = "@constant",
                    ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
                    ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
                    ["@lsp.typemod.variable.readonly"] = "@constant",
                }

                for newgroup, oldgroup in pairs(links) do
                    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
                end





                -- vim.api.nvim_set_hl(0, "@lsp.type.variable.rust", "TSVariable", { force = true })
                -- client.server_capabilities.semanticTokensProvider = nil

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
