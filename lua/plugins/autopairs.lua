--[[
  A super powerful autopair plugin for Neovim that supports multiple characters.
]]

return {
  'windwp/nvim-autopairs',
  event = { 'InsertEnter' },
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  config = function()
    local autopairs = require 'nvim-autopairs'

    autopairs.setup {
      check_ts = true,
      ts_config = {
        -- don't add pairs in treesitter nodes
        lua = { 'string' },
        -- don't add pairs in javascript template_string
        javascript = { 'template_string' },
        -- don't checko java
        java = false,
      },
    }

    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
