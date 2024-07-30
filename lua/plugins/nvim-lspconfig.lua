return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {},
      bufls = {},
      yamlls = {},
      cssls = {},
      puppet = { cmd = { "puppet-languageserver", "--stdio" } },
      ps1 = { "powershell_es" },
      sourcery = {
        init_options = {
          token = "AAAAA",
        },
      },
      gopls = {
        completeUnimported = true,
        usePlaceholder = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },
}
