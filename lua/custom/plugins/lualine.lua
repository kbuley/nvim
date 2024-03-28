return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- config = function(_, opts)
  config = function()
    -- require("lualine").setup({ options = opts })
    require("lualine").setup({})
  end,
}
