return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    -- formatters
    table.insert(opts.ensure_installed, "autoflake")
    table.insert(opts.ensure_installed, "bash-language-server")
    table.insert(opts.ensure_installed, "buf")
    table.insert(opts.ensure_installed, "codespell")
    table.insert(opts.ensure_installed, "fixjson")
    table.insert(opts.ensure_installed, "goimports-reviser")
    table.insert(opts.ensure_installed, "gotests")
    table.insert(opts.ensure_installed, "hclfmt")
    table.insert(opts.ensure_installed, "jq")
    table.insert(opts.ensure_installed, "powershell-editor-services")
    table.insert(opts.ensure_installed, "prettier")
    table.insert(opts.ensure_installed, "puppet-editor-services")
    table.insert(opts.ensure_installed, "protolint")
    table.insert(opts.ensure_installed, "salt-lint")
    table.insert(opts.ensure_installed, "shellharden")
    table.insert(opts.ensure_installed, "sourcery")
    table.insert(opts.ensure_installed, "xmlformatter")
    table.insert(opts.ensure_installed, "yamlfix")
    table.insert(opts.ensure_installed, "yamllint")
    table.insert(opts.ensure_installed, "yaml-language-server")
  end,
}
