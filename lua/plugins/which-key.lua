return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>t", group = "Telescope" },
      },
      { "<leader>T", group = "Terminal" },
    },
  },
}
