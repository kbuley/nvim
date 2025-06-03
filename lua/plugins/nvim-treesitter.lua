return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "gotmpl")
    table.insert(opts.ensure_installed, "graphql")
    table.insert(opts.ensure_installed, "jq")
    table.insert(opts.ensure_installed, "make")
    table.insert(opts.ensure_installed, "powershell")
    table.insert(opts.ensure_installed, "proto")
    table.insert(opts.ensure_installed, "puppet")
    table.insert(opts.ensure_installed, "ssh_config")
    table.insert(opts.ensure_installed, "tmux")
    table.insert(opts.ensure_installed, "toml")
  end,
}
