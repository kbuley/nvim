--[[
  A neovim plugin to persist and toggle multiple terminals during an editing session
--]]
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  keys = {
    {
      "<leader>ft",
      function()
        local count = vim.v.count1
        require("toggleterm").toggle(count, 15, LazyVim.root.get(), "horizontal")
      end,
      desc = "ToggleTerm (horizontal root_dir)",
    },
    {
      "<leader>fT",
      function()
        local count = vim.v.count1
        ---@diagnostic disable-next-line:undefined-field
        require("toggleterm").toggle(count, 15, vim.loop.cwd(), "horizontal")
      end,
      desc = "ToggleTerm (horizontal current_dir)",
    },
    {
      "<esc>",
      "<c-\\><c-n>",
      desc = "Normal Mode",
      mode = { "t" },
    },
    {
      "<C-h>",
      "<cmd>wincmd h<cr>",
      desc = "Go to left window",
      mode = { "t" },
    },
    {
      "<C-j>",
      "<cmd>wincmd j<cr>",
      desc = "Go to lower window",
      mode = { "t" },
    },
    {
      "<C-k>",
      "<cmd>wincmd k<cr>",
      desc = "Go to upper window",
      mode = { "t" },
    },
    {
      "<C-l>",
      "<cmd>wincmd l<cr>",
      desc = "Go to right window",
      mode = { "t" },
    },
    {
      "<C-w>",
      "<C-\\><C-n><C-w>",
      desc = "Window mappings",
      mode = { "t" },
    },
    {
      "<leader>Tf",
      function()
        local count = vim.v.count1
        require("toggleterm").toggle(count, 0, LazyVim.root.get(), "float")
      end,
      desc = "ToggleTerm (float root_dir)",
    },
    {
      "<leader>Th",
      function()
        local count = vim.v.count1
        require("toggleterm").toggle(count, 15, LazyVim.root.get(), "horizontal")
      end,
      desc = "ToggleTerm (horizontal root_dir)",
    },
    {
      "<leader>Tv",
      function()
        local count = vim.v.count1
        require("toggleterm").toggle(count, vim.o.columns * 0.4, LazyVim.root.get(), "vertical")
      end,
      desc = "ToggleTerm (vertical root_dir)",
    },
    {
      "<leader>Tn",
      "<cmd>ToggleTermSetName<cr>",
      desc = "Set term name",
    },
    {
      "<leader>Ts",
      "<cmd>TermSelect<cr>",
      desc = "Select term",
    },
    {
      "<leader>Tt",
      function()
        require("toggleterm").toggle(1, 100, LazyVim.root.get(), "tab")
      end,
      desc = "ToggleTerm (tab root_dir)",
    },
    {
      "<leader>TT",
      function()
        ---@diagnostic disable-next-line:undefined-field
        require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
      end,
      desc = "ToggleTerm (tab cwd_dir)",
    },
    { "<C-`>", "<cmd>ToggleTerm<CR>", desc = "ToggleTerm" },
  },
  opts = {
    open_mapping = [[<c-`>]],
    direction = "horizontal",
    hide_numbers = true,
    insert_mappings = true,
    terminal_mappings = true,
    start_in_insert = true,
    close_on_exit = true,
    persist_size = true,
    persist_mode = true,
  },
}
