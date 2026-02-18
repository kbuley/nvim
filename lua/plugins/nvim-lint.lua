return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      linters_by_ft = {
        ansible = { "ansible_lint" },
        bash = { "shellcheck" },
        json = { "jsonlint" },
        markdown = { "markdownlint-cli2" },
        proto = { "protolint", "buf_lint" },
        python = { "ruff" },
        sh = { "shellcheck" },
        sls = { "saltlint" },
        yaml = { "yamllint" },
        -- Let LazyVim's Go extra add golangcilint
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
  },
}
