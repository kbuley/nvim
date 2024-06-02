--[[
  Plugin for calling lazygit from within neovim.
--]]
return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  keys = {
    { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'LazyGit' },
  },
}
