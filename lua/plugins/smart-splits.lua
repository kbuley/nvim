return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    ignored_filetypes = {
      -- "nofile",
      -- "quickfix",
      -- "prompt",
      -- "lazy",
      -- "mason",
      -- "notify",
      -- "toggleterm",
      -- "TelescopePrompt",
      -- "Trouble",
      -- "codecompanion",
    },
    ignore_buftypes = {
      -- "terminal"
    },
    -- Enable multiplexer integration
    multiplexer_integration = "wezterm",
    -- Allow wrapping at screen edges to move to terminal panes
    at_edge = "wrap",
    -- Default resize amount
    default_amount = 3,
    -- Disable built-in keymaps
    ignored_events = {
      "BufWinEnter",
      "WinEnter",
    },
  },
}
