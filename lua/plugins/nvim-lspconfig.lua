return {
  "neovim/nvim-lspconfig",
  opts = {
    cmd_env = { GOFUMPT_SPLIT_LONG_LINES = "on" },
    servers = {
      bashls = {},
      cssls = {},
      puppet = { cmd = { "puppet-languageserver", "--stdio" } },
      sourcery = {
        init_options = {
          token = "user_VW8ThOq1Rpau0TxPQMt133iD-FxtGFg5MkyrDcfhFhFZPx1l84w_sH59XGI",
        },
      },
    },
  },
}
