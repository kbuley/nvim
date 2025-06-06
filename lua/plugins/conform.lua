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
      ansible = {},
      go = { "goimports-reviser", "gofumpt" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      json = { "fixjson", "jq" },
      lua = { "stylua" },
      proto = { "buf" },
      python = { "autoflake", "black" },
      sh = { "shfmt", "shellharden" },
      xml = { "xmlformatter" },
      yaml = { "yamlfix", env = {
        YAMLFIX_SEQUENCE_STYLE = "block_style",
      } },
      -- Use the "*" filetype to run formatters on all filetypes.
      ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
    -- Set this to change the default values when calling conform.format()
    -- This will also affect the default values for format_on_save/format_after_save
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- If this is set, Conform will run the formatter on save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    -- format_on_save = {
    --   -- I recommend these options. See :help conform.format for details.
    --   lsp_format = "fallback",
    --   timeout_ms = 500,
    -- },
    -- -- If this is set, Conform will run the formatter asynchronously after save.
    -- -- It will pass the table to conform.format().
    -- -- This can also be a function that returns the table.
    -- format_after_save = {
    --   lsp_format = "fallback",
    -- },
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
  },
}
