return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      ansible = { "ansible_lint" },
      json = { "jsonlint" },
      proto = { "protolint", "buf_lint" },
      sls = { "saltlint" },
      yaml = { "yamllint" },
    },
  },
}
