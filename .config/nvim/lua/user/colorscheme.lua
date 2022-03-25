-- vim.cmd [[
-- try
--   colorscheme darkplus
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]
local colorscheme = "nord"
vim.api.nvim_set_var('nord_contrast', true)
vim.api.nvim_set_var('nord_borders', true)
-- vim.api.nvim_set_var('gruvbox_material_palette', 'material')
-- vim.api.nvim_set_var('gruvbox_material_background', 'hard')

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
-- vim.api.nvim_command('highlight FloatBorder guibg=#45403d')
