return {
  "neovim/nvim-lspconfig",
  opts = {
    cmd_env = { GOFUMPT_SPLIT_LONG_LINES = "on" },
    servers = {
      bashls = {},
      --      buf_ls = {},
      cssls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = {
            disable = { "missing-fields" },
          },
        },
      },
      puppet = { cmd = { "puppet-languageserver", "--stdio" } },
      --      ps1 = { "powershell_es" },
      sourcery = {
        init_options = {
          token = "user_VW8ThOq1Rpau0TxPQMt133iD-FxtGFg5MkyrDcfhFhFZPx1l84w_sH59XGI",
        },
      },
    },
  },
}
