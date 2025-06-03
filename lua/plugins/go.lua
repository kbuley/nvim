return {
  {
    "zgs225/gomodifytags.nvim",
    cmd = { "GoAddTags", "GoRemoveTags", "GoInstallModifyTagsBin" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("gomodifytags").setup() -- Optional: You can add any specific configuration here if needed.
    end,
  },
  {
    "maxandron/goplements.nvim",
    ft = "go",
    opts = {
      -- The prefixes prepended to the type names
      prefix = {
        interface = "implemented by: ",
        struct = "implements: ",
      },
      -- Whether to display the package name along with the type name (i.e., builtins.error vs error)
      display_package = true,
      -- The namespace to use for the extmarks (no real reason to change this except for testing)
      namespace_name = "goplements",
      -- The highlight group to use (if you want to change the default colors)
      -- The default links to DiagnosticHint
      highlight = "Goplements",
    },
  },
  {
    "yanskun/gotests.nvim",
    ft = "go",
    config = function()
      require("gotests").setup()
    end,
  },
}
