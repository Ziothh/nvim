local present, null_ls = pcall(require, "null-ls")

if not present then
    error("null_ls plugin not found")
    os.exit(1, true)
    return
end

local M = {
    eslint_enabled = false,
    prettier_enabled = true,
}

local sources = {

    -- webdev stuff
    -- null_ls.builtins.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!

    null_ls.builtins.formatting.stylua,

    -- null_ls.builtins.diagnostics.fish,
    -- cpp
    -- null_ls.builtins.formatting.clang_format,
}

if M.eslint_enabled then
    table.insert(sources, null_ls.builtins.diagnostics.eslint_d.with {
        diagnostics_format = "[eslint] #{m}\n(#{c})",
    })

    table.insert(sources, null_ls.builtins.code_actions.eslint_d)
    -- table.insert(sources, null_ls.builtins.formatting.eslint_d)
end

if M.prettier_enabled then
    table.insert(sources, null_ls.builtins.formatting.prettierd.with {
        filetypes = {
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "json",
            "markdown",
            "scss",
            "less",
        }, -- so prettier works only on these filetypes
    })
    -- table.insert(sources, null_ls.builtins.formatting.prettierd)
end


M.setup = function()
    -- Disable when not in an eslint project
    if M.eslint_enabled == false and M.prettier_enabled == false then
        return
    end

    null_ls.setup {
        debug = true,
        sources = sources,
        on_attach = function(client, bufnr)
            -- if client.server_capabilities.documentSymbolProvider then
            --   local navic = require "nvim-navic"
            --   navic.attach(client, bufnr)
            -- end
        end,
    }
end

return M
