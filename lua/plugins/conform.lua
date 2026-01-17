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
        hcl = function(bufnr)
          if vim.bo[bufnr].filetype == "hcl.packer" then
            return { "packer_fmt" }
          end
          return { "hcl" }
        end,
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        codespell = {
          prepend_args = { "--ignore-words-list", "aks" },
          condition = function(self, ctx)
            return ctx.filename and ctx.filename ~= ""
          end,
        },
      },
    },
  },
}
