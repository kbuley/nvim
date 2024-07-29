return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "bash-language-server")
    table.insert(opts.ensure_installed, "autoflake")
    table.insert(opts.ensure_installed, "buf")
    table.insert(opts.ensure_installed, "hclfmt")
    table.insert(opts.ensure_installed, "jq")
    table.insert(opts.ensure_installed, "xmlformatter")
    table.insert(opts.ensure_installed, "yamlfix")
    table.insert(opts.ensure_installed, "goimports-reviser")
    table.insert(opts.ensure_installed, "gotests")
    table.insert(opts.ensure_installed, "buf")
    table.insert(opts.ensure_installed, "protolint")
    table.insert(opts.ensure_installed, "hadolint")
    table.insert(opts.ensure_installed, "salt-lint")
    table.insert(opts.ensure_installed, "shellcheck")
    table.insert(opts.ensure_installed, "yaml-language-server")
    table.insert(opts.ensure_installed, "yamllint")
    table.insert(opts.ensure_installed, "tflint")
    table.insert(opts.ensure_installed, "puppet-editor-services")
    table.insert(opts.ensure_installed, "powershell-editor-services")
  end,
}