--[[
  Just install the plugin and things will work just work, no configuration needed.
--]]
return {
  'RRethy/vim-illuminate',
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { 'lsp' },
    },
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
}
