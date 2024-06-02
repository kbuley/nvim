--[[
  A simple wrapper around git worktree operations, create, switch, and delete. There is some assumed workflow within this plugin, but pull requests are welcomed to fix that).
--]]
return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('git-worktree').setup()
    require('telescope').load_extension 'git_worktree'
  end,
}
