return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      fish = {},
      proto = { "protolint", "buf_lint" },
      docker = { "hadolint" },
      sls = { "saltlint" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
      terraform = { "tflint" },
      json = { "jsonlint" },
    },
  },
}
