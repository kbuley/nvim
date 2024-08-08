--[[
  A neovim plugin to persist and toggle multiple terminals during an editing session
--]]
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  keys = {
    { "<C-`>", "<cmd>ToggleTerm<CR>", desc = "Dismiss All Notifications" },
  },
}
