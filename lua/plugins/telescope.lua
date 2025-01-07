return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>t", group = "telescope" },
    { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>tr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>td", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>tq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
    { "<leader>ta", "<cmd>Telescope aerial<cr>", desc = "Aeriel" },
    { "<leader>tg", "<cmd>Telescope grep_string<cr>", desc = "Grep" },
    { "<leader>ts", "<cmd>Telescope live_grep<cr>", desc = "Search" },
    { "<leader>tp", "<cmd>Telescope neovim-project discover<cr>", desc = "Projects" },
    { "<leader>tn", "<cmd>Noice telescope<cr>", desc = "Notifications " },
  },
}
