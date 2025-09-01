return {
  "LazyVim/LazyVim",
  requires = { "catppuccin/nvim" },
  opts = {
    colorscheme = "catppuccin-mocha",
  },
  -- Remove this after the PR is fixed: https://github.com/LazyVim/LazyVim/pull/6354
  {
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
}
