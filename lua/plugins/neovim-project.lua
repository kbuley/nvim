--[[
  Neovim project manager maintains your recent project history and uses Telescope to select from autosaved sessions.
--]]
return {
  "coffebar/neovim-project",
  opts = {
    projects = { -- define project roots
      "~/Projects/*",
      "~/Projects-Personal/*",
      "~/.config/*",
    },
    dashboard_mode = true,
    picker = {
      type = "telescope",
    },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
