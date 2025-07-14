return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
██╗  ██╗███████╗██╗   ██╗      ██╗   ██╗██╗███╗   ███╗
██║ ██╔╝██╔════╝██║   ██║      ██║   ██║██║████╗ ████║
█████╔╝ █████╗  ██║   ██║█████╗██║   ██║██║██╔████╔██║
██╔═██╗ ██╔══╝  ╚██╗ ██╔╝╚════╝╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██╗███████╗ ╚████╔╝        ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝╚══════╝  ╚═══╝          ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "p",
            desc = "Projects",
            action = ":NeovimProjectDiscover",
          },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          --{ action = ':lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    terminal = {
      win = {
        position = "float",
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    vim.api.nvim_create_user_command("Dashboard", Snacks.dashboard.open, {})
    require("snacks").toggle.zoom():map("<A-m>", { mode = { "n", "x", "i", "t" } })
  end,
}
