return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      ansible = { "ansible_lint" },
      json = { "jsonlint" },
      markdown = { "markdownlint-cli2" },
      proto = { "protolint", "buf_lint" },
      sls = { "saltlint" },
      yaml = { "yamllint" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        args = {
          "--config",
          vim.fn.stdpath("config") .. "/lua/configs/nvim.markdownlint.jsonc",
          "$FILENAME",
        },
      },
    },
  },
}
