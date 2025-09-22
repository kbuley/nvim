return {
  -- Add colorschemes here
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
  { "ellisonleao/gruvbox.nvim" },

  -- Tell LazyVim which one to set as default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
