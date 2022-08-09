-- NORD
-- local colorscheme = "nord"
-- vim.api.nvim_set_var('nord_contrast', true)
-- vim.api.nvim_set_var('nord_borders', true)
-- vim.api.nvim_command('highlight IncSearch guibg=#4C566A')

-- GRUVBOX
-- local colorscheme = "gruvbox_material"
-- vim.api.nvim_set_var('gruvbox_material_palette', 'material')
-- vim.api.nvim_set_var('gruvbox_material_background', 'hard')
-- vim.api.nvim_command('highlight FloatBorder guibg=#45403d')

-- CATPPUCCIN
local colorscheme = "catppuccin"
require("user.colorschemes.catppuccin")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
