return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      -- Disable features we don't need
      disable_defaults = false,
      lsp_cfg = false,
      lsp_keymaps = false,
      lsp_codelens = false,
      diagnostic = false,
      dap_debug = false,
      dap_debug_keymap = false,
      dap_debug_gui = false,
      test_runner = false,
      run_in_floaterm = false,
      trouble = false,
      luasnip = false,
      -- Only check for tools we actually want
      go = "go",
      goimports = "gopls",
      fillstruct = "gopls",
      gofmt = "gofumpt",
      -- Tools we're installing
      golines = "golines",
      gotestsum = "gotestsum",
      govulncheck = "govulncheck",
      mockgen = "mockgen",
      callgraph = "callgraph",
      -- Explicitly set tools we're skipping to empty string to silence warnings
      richgo = "",
      ginkgo = "",
      iferr = "",
      gonew = "",
      gomvp = "",
      fillswitch = "",
      gojsonstruct = "",
      ["json-to-struct"] = "",
      ["go-enum"] = "",
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  keys = {
    { "<leader>gaj", "<cmd>GoAddTag json<cr>", desc = "Add json tags", ft = "go" },
    { "<leader>gay", "<cmd>GoAddTag yaml<cr>", desc = "Add yaml tags", ft = "go" },
    { "<leader>gat", "<cmd>GoAddTag<cr>", desc = "Add tags", ft = "go" },
    { "<leader>grj", "<cmd>GoRmTag json<cr>", desc = "Remove json tags", ft = "go" },
    { "<leader>gry", "<cmd>GoRmTag yaml<cr>", desc = "Remove yaml tags", ft = "go" },
    { "<leader>grt", "<cmd>GoRemoveTags<cr>", desc = "Remove tags", ft = "go" },
  },
}
