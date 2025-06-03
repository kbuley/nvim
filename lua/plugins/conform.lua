return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["html"] = { "prettier" },
        ["ansible"] = {},
        ["go"] = { "goimports-reviser", "gofumpt" },
        ["javascript"] = { "prettierd", "prettier", stop_after_first = true },
        ["json"] = { "fixjson", "jq" },
        ["proto"] = { "buf" },
        ["python"] = { "autoflake", "black" },
        ["sh"] = { "shfmt", "shellharden" },
        ["xml"] = { "xmlformatter" },
        ["yaml"] = { "yamlfix", env = {
          YAMLFIX_SEQUENCE_STYLE = "block_style",
        } },
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
    },
  },
}
