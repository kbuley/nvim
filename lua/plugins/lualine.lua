--[[
  A blazing fast and easy to configure Neovim statusline written in Lua.
--]]
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- config = function(_, opts)
  config = function()
    -- require("lualine").setup({ options = opts })
    require('lualine').setup {}
  end,
}
