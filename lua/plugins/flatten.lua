return {
  "willothy/flatten.nvim",
  --  config = true,
  -- or pass configuration with
  -- opts = {  }
  -- Ensure that it runs first to minimize delay when opening file from terminal
  opts = {
    integrations = {
      wezterm = true,
    },
  },
  lazy = false,
  priority = 1001,
}
