return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["ansible"] = {},
        ["go"] = { "goimports-reviser", "golines", "gofumpt" },
        ["html"] = { "prettier" },
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["json"] = { "jq" },
        ["markdown"] = { "prettier" },
        ["proto"] = { "buf" },
        ["python"] = { "ruff_organize_imports", "ruff_format" },
        ["sh"] = { "shfmt" },
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
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        codespell = {
          prepend_args = { "--ignore-words-list", "aks" },
          condition = function(_, ctx)
            return ctx.filename and ctx.filename ~= ""
          end,
        },
      },
    },
  },
}
