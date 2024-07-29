return {
  "stevearc/conform.nvim",
  dependencies = {
    "mfussenegger/nvim-lint",
  },
  keys = {
    {
      "<leader>cL",
      function()
        local lint = require("lint")
        lint.linters_by_ft = lint.linters_by_ft or {}
        lint.try_lint()
      end,
      mode = { "n" },
      desc = "Lint",
    },
  },
  opts = {
    formatters_by_ft = {
      fish = {},
      python = { "autoflake", "black" },
      proto = { "buf" },
      hcl = { "hclfmt" },
      json = { "jq" },
      xml = { "xmlformatter" },
      yaml = { "yamlfix" },
      go = { "goimports-reviser", "gofumpt", "gomodifytags" },
    },
  },
}
