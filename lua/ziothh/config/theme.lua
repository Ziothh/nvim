-- Theming
-- vim.opt.background = "dark"
--- Set colorscheme
vim.o.termguicolors = true
vim.opt.background = "dark"
--
local theme = "rose-pine";
-- local theme = "sonokai";
-- require(theme).setup({
--     -- disable_background = true
-- })


function ColorMyPencils(color)
    color = color or theme
    vim.cmd.colorscheme(color)
    
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.g.sonokai_style = 'andromeda'
    -- vim.g.sonokai_better_performance = 1

end

ColorMyPencils()
