--[[
  tmux integration for nvim features pane movement and resizing from within nvim.
--]]
return {
  "aserowy/tmux.nvim",
  config = function()
    require("tmux").setup()
  end,
}
